#include <iNet.au3>

; #INDEX# =======================================================================================================================
; Title .........: _nPing
; AutoIt Version :
; Language ......: English
; Description ...: Function to perform multi Ping.
; Author(s) .....: core engine is Manadar's "nping" retrieved at the following post
;                  http://www.autoitscript.com/forum/topic/108060-nping-console-network-pinger-network-sweeper-network-scanner
;                  adapted to this UDF by PincoPanco
; ===============================================================================================================================

; #CURRENT# =====================================================================================================================
; _nPing                    multi IP pinger
; ===============================================================================================================================

; #INTERNAL_USE =================================================================================================================
; _LanParameters            given IP and mask generate [and display] various lan parameters
; _CIDR_To_Mask             transform a CIDR number (1 - 32) to the corresponding 4 digit mask
; _Mask_To_CIDR             transform a 4 digit mask to the corresponding CIDR number (1 - 32)
; _GetSubnetMask            given the local IP returns the related subnet mask (thanks to dragan)
; _Convert_To_Binary        from decimal to binary
; _Bin_To_Dec               from binary to decimal
; _FileReadToArray_mod      read a file of IP in a 1D array, if is a csv and a separator is passed a 2D array is returned
; _GetIpAddressList         Generate the IP list to Ping
; _Make_Range               Given an IP and his mask, this function return the full LAN "range" for _nPing
; _GetLanParameters         calculate all IP/subnet related parameters
; _isIPaddr                 check if passed IP is a plausible IP
; _isSNmask                 check if passed mask is a plausible mask
; _Progress                 shows a progress bar for the current scan
; ===============================================================================================================================

; #FUNCTION# ====================================================================================================================
; Name...........: _nPing
; Description ...: returns an array containing: clients responding to ping or clients not responding or both. See $ReturnFlag
; Syntax.........: _nPing([[$IP]|[$IPArray]|[$IPrange]],[[$NetMask]|[$column]], [$ReturnFlag], [$Resolve], [$MyFunction])
; Parameters ....: [[$IP]|[$IPArray]|[$IPrange]] - An IP address or an 1D or 2D array (0 based) or an IPrange(*)
;                  $NetMask  - An 4 digit Net Mask or a CIDR notation value (numbers of bit from 1 to 32)
;                              if previous parameter is an 2D array then this parameter contains the
;                              nr. of the column that contains the addresses to be pinged
;                  $ReturnFlag - 0|1|2, what to return: 0=all cliensts; 1=responding clients; 2= not responding clients(**)
;                  $Resolve - O or 1, if IP lookup name resolution must be performed; 1 = yes, 0 = no
;                  $MyFunction - an User Defined Function to be called each time a PING complete (default is progress bar)
;                                the called function receives 1 parameter that is an array containing the following 6 parameters:
;                                [0] nr. of total addresses under process
;                                [1] nr. of ping already finished
;                                [2] IP just processed
;                                [3] resolved Host name or -1 if IP is down
;                                [4] roundtrip of this ping or -1 if IP is down
;                                [5] Index of this IP within the caller's passed array
;                                by default is called the _Progress() function that will display the progress bar
; Return values .: Success - an 2D array containing:
;                  first row ($array[0][x]) contains: [0][0]= nr. of returned host; [0][1]= total roundtrip
;                  other rows: [n][0]=Address; [n][1]=lookup name; [n][2]=roundtrip; [n][3]=index in the passed array***
;                  Failure - -1, sets @error
;                  |1 - too many IP, max 16777216 ($MAX_HOSTS)
;                  |2 - wrong array dimensions or wrong column number
;                  |3 - wrong IP
;                  |4 - wrong subnet mask
;                  |5 - bad "range" or wrong IP error
;                  |6 - Windows Sockets Error
;                  |7 - (not used)
;                  |8 - DLL call error (reading local subnet mask)
;
;             (*)  IPrange is a string as below
;                  "192.168.0.0-1"      will ping these addresses: 192.168.0.0 and 192.168.0.1
;                  "192.168.20.*"       will ping everything in the range from 192.168.20.1 to 192.168.20.255
;                  "192.168.0-1.1-254"  will ping everything in the range from 192.168.0.1 to 192.168.1.254
;
;             (**) returnead 2D array has the following 4 columns:
;                  first row contains: [0][0]= nr. of returned host; [0][1]= total roundtrip
;                  following rows contains fields as below
;                  +-------------------------+-------------------------+
;                  | nr of elements in array | total roundtrip         |
;                  +-------------------------+-------------------------+-------------------------+-------------------------+
;                  | IP address              | [hostname] ( -1)        | roundtrip (or -1)       | index ***               |
;                  +-------------------------+-------------------------+-------------------------+-------------------------+
;
;            (***) since the returned array has not the same nr. of rows and also has not the same order of the array in input,
;                  this index is a reference to "bind" both arrays.
;                  It is more useful if the input array is a 2D array and you have to bind the rows containing results
;                  with related fields (array elements) in the "source" array

; Author ........:
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================

Func _nPing($networkRange = "", $MyMask = "", $ReturnFlag = 1, $Resolve = 0, $MyFunction = "_Progress")

    Static $TCP = TCPStartup() ; this should be used at the beginning of the main program instead of inside the Func()
    Static $dig = FileExists(".\dig\dig.exe") ; this is for IP to hostname resolution. if dig.exe exists will be used. (faster than _TCPIpToName)

    Local $MAX_PROCESS = 20 ; A maximum number of processes (25)
    ; Global $MAX_HOSTS = 16777216 ; A maximum number of hosts to ping due to AutoIt's array limit size
    Local $_IPup[1][4] ; will contain results of PINGs [IP][roundrip or -1]

    ;   check what has been required from caller
    If $networkRange = "" Then ; no parameters passed, so scan local network
        ; ConsoleWrite("debug: no IP/range provided, I will scan the local LAN" & @CRLF)
        $networkRange = _Make_Range(TCPNameToIP(@ComputerName), _GetSubnetMask(TCPNameToIP(@ComputerName))) ; retrieve local LAN and Subnet Mask values
        If @error Then Return SetError(@error, @extended, -1)
        ; ConsoleWrite("debug: network range=" & $networkRange & @CRLF)

    ElseIf IsArray($networkRange) Then ; ----- is an array -----------------------------+
        ; if is an 2D array then $MyMask contains the column else is ignored            |
        If UBound($networkRange) > 16777216 Then Return SetError(1, 0, -1) ;            | too many IP > $MAX_HOSTS
        ; If UBound($networkRange, 0) <> 1 Then Return SetError(2, 0, -1) ;             |
        If UBound($networkRange, 0) > 2 Then Return SetError(2, 0, -1) ;                | max 2D array
        If UBound($networkRange, 0) = 1 Then ;                                          |
            $aArray = $networkRange ;   $aArray = all IP to scan                        |
        Else ;                ----- it is a 2D array -----                              |
            ; the number of the column with addresses is in $MyMask parameter           |
            If $MyMask > UBound($networkRange, 2) - 1 Then Return SetError(2, 0, -1) ;  | wrong column
            Local $aArray[UBound($networkRange)] ;                                      |
            For $i = 0 To UBound($networkRange) - 1 ;                                   |
                $aArray[$i] = $networkRange[$i][$MyMask] ;                              |
            Next ;                                                                      |
        EndIf ;                                                                         |
        ; ------------------------------------------------------------------------------+

    ElseIf _isIPaddr($networkRange) Then ; single IP
        ; ConsoleWrite("debug: single IP value received" & @CRLF)
        If $MyMask <> "" Then ; is there a subnet?
            If Not _isSNmask($MyMask) Then ; wrong 4 digit mask
                If $MyMask > 0 And $MyMask < 33 Then ; is it a CIDR notation number? (nr. of bits of mask (1 to 32))
                    $MyMask = _CIDR_To_Mask($MyMask)
                Else
                    Return SetError(4, 0, -1) ; wrong mask provided
                EndIf
            EndIf
            $networkRange = _Make_Range($networkRange, $MyMask) ; generate the "range" of all IP belonging to that subnet mask
        EndIf
    EndIf

    If Not IsArray($networkRange) Then
        ; ConsoleWrite("debug: Is not an Array" & @CRLF)
        ; if $networkRange is NOT an array then it is a "range"
        ; either passed as parameter by caller or generated by above checks
        $aArray = _GetIpAddressList($networkRange) ; Generate the list of IP to be pinged
        If @error Then Return SetError(5, 0, -1) ; IP range error
    EndIf
    ;
    ;   _ArrayDisplay($aArray,"debug") ; $aArray should contain the IP to be pinged by _nPing
    ;
    ;   ***********************************************************************************************************
    ;   here start of nping core by Manadar (slightly modified)
    ;   http://www.autoitscript.com/forum/topic/108060-nping-console-network-pinger-network-sweeper-network-scanner
    ;   ***********************************************************************************************************

    If $ReturnFlag = 0 Then ; make room for all clients
        ReDim $_IPup[UBound($aArray) + 1][4] ; $_IPup will contain results
    EndIf

    Local $aProcess[$MAX_PROCESS] ; An array to keep a reference to spawned processes, in the next loop we fill it with value 0 for reference
    For $i = 0 To UBound($aProcess) - 1
        $aProcess[$i] = 0
    Next

    Local $i = 0 ; which IP are we currently trying to ping ( based on array )
    Local $iFinished = 0 ; how many processes have finished pinging
    Local $iUp = 0 ; Total hosts that are UP
    Local $iDown = 0 ; Total hosts that are DOWN
    Local $iTotalRoundTrip = 0 ; Total roundtrip (all the +ms added together)
    While 1
        ; We check all the currently running processes
        For $n = 0 To UBound($aProcess) - 1
            ; Check if we need a spot, and there is an existing spot here
            If ($i <> UBound($aArray) And $aProcess[$n] == 0) Then
                $aProcess[$n] = _MSPing($i, $aArray[$i]) ; Start a new Ping process
                $i += 1 ; Increment $i so we can do the next process the next time around
            Else
                ; Check if this process has been spawned and the process is ready
                If ($aProcess[$n] <> 0 And _MSPingIsReady($aProcess[$n])) Then ; has finished to ping
                    ; results of endings pings. (Get results from the various Pimg commands)
                    $sHostname = _MSPingGetHostname($aProcess[$n])
                    $sResult = _MSPingGetResult($aProcess[$n])
                    $sIndex = ___MSPingGetIndex($aProcess[$n]) ; new, added by me (zero based)
                    ; ConsoleWrite("debug: " & $sIndex & " : " & $sHostname & " : " & $sResult & @CRLF)
                    ; --------------------------------------------------------------------------------------------------------------------------------------------------------------
                    If ($sResult <> -1) Then ; current IP is UP
                        ; ConsoleWrite("debug: " & $sHostname & " has a roundtrip of " & $sResult & " ms" & @CRLF)
                        $iUp += 1
                        If $ReturnFlag < 2 Then ; if return all(0) or responding only(1)

                            If $ReturnFlag = 1 Then ; 1 = return back only responding IP
                                ReDim $_IPup[$iUp + 1][4]
                                $_IPup[$iUp][3] = $sIndex ; the index of the passed array that contains this IP
                                $sIndex = $iUp
                            Else ; $ReturnFlag = 0 Then keep all clients
                                $sIndex += 1
                                $_IPup[$sIndex][3] = $sIndex - 1
                            EndIf

                            $_IPup[$sIndex][0] = $sHostname
                            If $Resolve Then ; ------------ resolve IP to hostname ------------
                                If _isIPaddr($_IPup[$sIndex][0]) Then ; is it an IP ? (or an hostname)
                                    If $dig Then ; resolve with dig if is present (much faster especially on passive devices without a host name)
                                        Local $digID = Run(".\dig\dig.exe -x " & $_IPup[$sIndex][0] & " +short", "", @SW_HIDE, 0x2)
                                        Do
                                            $_IPup[$sIndex][1] &= StdoutRead($digID) ; resolved IP to name (if resolvable else empty)
                                        Until @error
                                    Else
                                        ; _TCPIpToName is very slow to return if the remote IP do not belongs to a windows client (example a printer or a router)
                                        $_IPup[$sIndex][1] = _TCPIpToName($_IPup[$sIndex][0])
                                    EndIf
                                Else
                                    $_IPup[$sIndex][1] = $_IPup[$sIndex][0]
                                EndIf
                            EndIf ; End of name resolution -------------------------------------
                            $_IPup[$sIndex][2] = $sResult ; roundtrip of the ping
                            $iTotalRoundTrip += $sResult
                        EndIf
                    Else ; current IP is down ----------------------------------------------------------------------------------------------------------------------------------------
                        $iDown += 1
                        If $ReturnFlag = 0 Then ; 0 return back all IP, responding and not responding
                            $sIndex += 1
                            $_IPup[$sIndex][0] = $sHostname
                            $_IPup[$sIndex][1] = -1 ; loockup name
                            $_IPup[$sIndex][2] = -1 ; roundtrip
                            $_IPup[$sIndex][3] = $sIndex - 1
                            ;   ElseIf $ReturnFlag = 1 Then ; $ReturnFlag = 1 return only responding
                            ;   nothing to store
                        ElseIf $ReturnFlag = 2 Then ; $ReturnFlag = 2 return only not responding
                            ReDim $_IPup[$iDown + 1][4]
                            $_IPup[$iDown][0] = $sHostname
                            $_IPup[$iDown][1] = -1
                            $_IPup[$iDown][2] = -1
                            $_IPup[$iDown][3] = $sIndex
                            $sIndex = $iDown
                        EndIf
                    EndIf
                    ; ***************************************************
                    ; Free up an empty space for the next address to Ping
                    $aProcess[$n] = 0
                    ; Increment the total of processes that have finished
                    $iFinished += 1

                    If ($sResult <> -1 And $ReturnFlag <> 2) Or ($sResult = -1 And $ReturnFlag <> 1) Then
                        ; call an UDF to track and manage what's going on during the scan;
                        ; an array is passed to the called function with the following 6 parameters:
                        ; 0) nr. of total addresses under process
                        ; 1) nr. of ping already finished
                        ; 2) IP just processed
                        ; 3) resolved Host name or -1 if IP is down
                        ; 4) roundtrip of this ping or -1 if IP is down
                        ; 5) Index of this IP within the caller's passed array
                        ; by default is called the _Progress() function that will display the progress bar
                        Local $aPass_Args[6] = [UBound($aArray), $iFinished, $_IPup[$sIndex][0], $_IPup[$sIndex][1], $_IPup[$sIndex][2], $_IPup[$sIndex][3]]
                        Local $aArgs[2] = ["CallArgArray", $aPass_Args]
                        Call($MyFunction, $aArgs)
                    Else
                        Local $aPass_Args[6] = [UBound($aArray), $iFinished, $sHostname, -1, -1, $sIndex]
                        Local $aArgs[2] = ["CallArgArray", $aPass_Args]
                        Call($MyFunction, $aArgs)
                    EndIf

                    ; If the total number of finished processes
                    If ($iFinished == UBound($aArray)) Then ExitLoop 2 ;  Exit -----+
                EndIf ;                                                             |
            EndIf ;                                                                 |
        Next ;                                                                      |
        Sleep(50) ; Give existing ping commands some time to process the request    |
    WEnd ;                                                                          |
    ;                                                           <-------------------+
    ;  fill record [0]
    If $ReturnFlag = 0 Then ; return all
        $_IPup[0][0] = $iUp + $iDown
        $_IPup[0][1] = $iUp ; $iTotalRoundTrip
        ;   $_IPup[0][2] = $iDown
    ElseIf $ReturnFlag = 1 Then ; return only up
        $_IPup[0][0] = $iUp
        $_IPup[0][1] = $iTotalRoundTrip
        ;   $_IPup[0][2] = $iDown
    ElseIf $ReturnFlag = 2 Then ; return only down
        $_IPup[0][0] = $iDown
        $_IPup[0][1] = -1
        ;   $_IPup[0][2] = $iUp
    EndIf
    Return $_IPup ; - - - The end of scan - - -
EndFunc   ;==>_nPing

Func _GetIpAddressList($ipFormat) ; Generate the IP list to Ping
    If $ipFormat = "" Then
        Return SetError(5, 0, -1) ; no IP to ping
    EndIf

    $ipFormat = StringReplace($ipFormat, "*", "1-255") ; change * with  "1-255"
    $ipSplit = StringSplit($ipFormat, ".")

    If $ipSplit[0] <> 4 Then ; if it is not an IP address then check if it is an hostname
        Static $TCP = TCPStartup()
        Local $ret[1] = [TCPNameToIP($ipFormat)] ; from hostname to IP
        If @error Then Return SetError(6, @error, -1) ; windows API WSAGetError Windows Sockets Error in @extended
        Return $ret ; -----> return
    EndIf

    For $i = 1 To 4 ; controls once again
        If Not StringRegExp($ipSplit[$i], "[0-9\-]*") Then ; are 4 octets numbers
            Static $TCP = TCPStartup()
            Local $ret[1] = [TCPNameToIP($ipFormat)] ; if not number try to decode from host to IP
            If @error Then Return SetError(6, @error, -1) ; windows API WSAGetError. Windows Sockets Error in @extended
            Return $ret ; -----> return
        EndIf
    Next
    ;   $ipFormat is not an hostname
    Local $ipRange[4][2], $totalPermu = 1

    For $i = 0 To 3
        If StringInStr($ipSplit[$i + 1], "-") Then ; control the presence of the "-" sign
            $m = StringSplit($ipSplit[$i + 1], "-")
            $ipRange[$i][0] = $m[1]
            $ipRange[$i][1] = $m[2]
        Else
            $n = Number($ipSplit[$i + 1])
            $ipRange[$i][0] = $n
            $ipRange[$i][1] = $n
        EndIf
        $totalPermu *= $ipRange[$i][1] - $ipRange[$i][0] + 1 ; total number of IP to check
        If ($ipRange[$i][0] < 0 Or $ipRange[$i][0] > 255) Or ($ipRange[$i][1] < 0 Or $ipRange[$i][1] > 255) Then Return SetError(3, 0, -1) ; wrong IP
    Next
    If $totalPermu > 16777216 Then ; > $MAX_HOSTS
        Return SetError(1, String($totalPermu), -1) ; too many IP
    EndIf

    Local $result[$totalPermu], $i = 0

    For $a = $ipRange[0][0] To $ipRange[0][1]
        For $b = $ipRange[1][0] To $ipRange[1][1]
            For $c = $ipRange[2][0] To $ipRange[2][1]
                For $d = $ipRange[3][0] To $ipRange[3][1]
                    $result[$i] = $a & "." & $b & "." & $c & "." & $d ; $result contains the IP addresses to ping
                    $i += 1
                Next
            Next
        Next
    Next

    Return $result
EndFunc   ;==>_GetIpAddressList

Func _Exit()
    Exit
EndFunc   ;==>_Exit

Func _MSPing($Array_ndx, $sHostname, $timeout = 4000) ;$timeout = 50) ; start a new Ping
    Local $return_struc[5]
    ; [0] = Result (in ms)
    ; [1] = The hostname originally used
    ; [2] = Process handle (for internal use only)
    ; [3] = Buffer (for internal use only)
    ; [4] = Index of IP in source array **new**

    $return_struc[1] = $sHostname
    $return_struc[2] = Run("ping " & $sHostname & " -n 1 -w " & $timeout, "", @SW_HIDE, 0x2) ; 0x2 -> $STDOUT_CHILD)
    $return_struc[4] = $Array_ndx

    Return $return_struc
EndFunc   ;==>_MSPing

Func _MSPingIsReady(ByRef $return_struc) ; check if Ping has finished
    Return ___MSPingReadOutput($return_struc)
EndFunc   ;==>_MSPingIsReady

Func _MSPingGetResult($return_struc)
    Return $return_struc[0]; [0] = Result (in ms)
EndFunc   ;==>_MSPingGetResult

Func _MSPingGetHostname($return_struc) ; returns the hostname
    Return $return_struc[1]; [1] = The hostname originally used
EndFunc   ;==>_MSPingGetHostname

; Internal use only
Func ___MSPingReadOutput(ByRef $return_struc) ; peek result of DOS Ping command
    $data = StdoutRead($return_struc[2]) ; [2] = Process handle (for internal use only)
    If (@error) Then ; if ping has finished
        ___MSPingParseResult($return_struc) ; extract time taken by ping
        Return 1 ; 1 = finished
    Else
        $return_struc[3] &= $data ; [3] = Buffer (for internal use only) ; contains DOS output
        Return 0 ; 0 = not yet finished
    EndIf
EndFunc   ;==>___MSPingReadOutput

; Internal use only
Func ___MSPingParseResult(ByRef $return_struc) ; extract from Ping command the millisecond value
    $result = StringRegExp($return_struc[3], "([0-9]*)ms", 3); [3] = DOS command output is here
    If @error Then
        $return_struc[0] = -1 ; [0] = Result (in ms) -1 if error
    Else
        $return_struc[0] = $result[0] ; returns the first millisecond value retrieved from Ping
    EndIf
EndFunc   ;==>___MSPingParseResult

; Internal use only - new (added by me)
Func ___MSPingGetIndex(ByRef $return_struc) ; Index of the current IP in passed array
    Return $return_struc[4]
EndFunc   ;==>___MSPingGetIndex

; = = = = = net related functions = = = = =

Func _Make_Range($ipLan, $sMask) ; Given an IP and his mask, this function return the full LAN "range" for _nPing
    Local $aLan = _GetLanParameters($ipLan, $sMask)
    If @error Then Return SetError(@error, @extended, -1)
    Return $aLan[7][0]
EndFunc   ;==>_Make_Range

Func _GetLanParameters($theIP1, $sSubNet)
    ; ------------------------------------------
    ; calculate all IP/subnet related parameters
    ; ------------------------------------------
    If Not _isIPaddr($theIP1) Then Return SetError(3, 0, -1) ; wrong IP address
    ;check on subnet
    If Not _isSNmask($sSubNet) Then ; it is not a valid 4 digit subnet
        If $sSubNet > 0 And $sSubNet < 33 Then ; is it a CIDR notation number? nr. of bits 1 to 32
            $sSubNet = _CIDR_To_Mask($sSubNet)
        Else
            Return SetError(4, 0, -1) ; wrong Mask provided
        EndIf
    EndIf

    Local $aLan[8][5] ; net parameters container
    Local $sDot[2] = ['', '.'] ; used as IP octets separator
    Local $aIP = StringSplit($theIP1, '.'), $aSubNet = StringSplit($sSubNet, '.')
    ; split IP address in single octets and calculate related parameters
    For $i = 1 To 4
        $aLan[0][$i] = $aIP[$i] ;                           IP
        $aLan[1][$i] = $aSubNet[$i] ;                       NetMask
        $aLan[2][$i] = BitNOT($aLan[1][$i] - 256) ;         Wildcard, is the inverse of subnet: BitNot($NetMask - 256)
        $aLan[3][$i] = BitAND($aLan[0][$i], $aLan[1][$i]) ; LanAddress  BitAnd(IP, netmask)
        $aLan[4][$i] = BitOR($aLan[0][$i], $aLan[2][$i]) ;  Broadcast address
        $aLan[5][$i] = $aLan[3][$i] ;                       preset First host ; will be $NetAddress + 1
        $aLan[6][$i] = $aLan[4][$i] ;                       preset Last host  ; will be $Broadcast  -1
    Next
    If $sSubNet <> "255.255.255.255" Then
        $aLan[5][4] = BitOR($aLan[5][4], 1) ;                   First host $NetAddress + 1 (Turn last bit ON)
        $aLan[6][4] = BitAND($aLan[6][4], 254) ;                Last host $Broadcast  -1 (Turn last bit OFF)
    EndIf

    For $i = 1 To 4
        $aLan[0][0] &= $aLan[0][$i] & $sDot[$i < 4] ; [0] IP
        $aLan[1][0] &= $aLan[1][$i] & $sDot[$i < 4] ; [1] NetMask
        $aLan[2][0] &= $aLan[2][$i] & $sDot[$i < 4] ; [2] Wildcard
        $aLan[3][0] &= $aLan[3][$i] & $sDot[$i < 4] ; [3] Network
        $aLan[4][0] &= $aLan[4][$i] & $sDot[$i < 4] ; [4] Broadcast
        $aLan[5][0] &= $aLan[5][$i] & $sDot[$i < 4] ; [5] First host
        $aLan[6][0] &= $aLan[6][$i] & $sDot[$i < 4] ; [6] Last host
        ;                                             [7][0] Range for _nPing
        If $aLan[5][$i] = $aLan[6][$i] Then
            $aLan[7][0] &= $aLan[5][$i] & $sDot[$i < 4]
        Else
            $aLan[7][0] &= $aLan[5][$i] & "-" & $aLan[6][$i] & $sDot[$i < 4]
        EndIf
    Next
    ; MsgBox(0, "net", "IP address: " & @TAB & $aLan[0][0] & @CRLF & "Subnet:      " & @TAB & $aLan[1][0] & @CRLF & "Wildcard:   " & @TAB & $aLan[2][0] & @CRLF & "Network:   " & @TAB & $aLan[3][0] & @CRLF & "Broadcast: " & @TAB & $aLan[4][0] & @CRLF & "First host:   " & @TAB & $aLan[5][0] & @CRLF & "Last host:   " & @TAB & $aLan[6][0])
    ; _ArrayDisplay($aLan, "IP/subnet related parameters")
    Return $aLan
EndFunc   ;==>_GetLanParameters
; #FUNCTION# ====================================================================================================================
; Name...........: _LanParameters
; Description ...: given an IP and his subnet returns [and  displays] the following values in dec and binary format:
;                  |IP Address
;                  |Netmask
;                  |Wildcard
;                  |Network Address
;                  |Broadcast Address
;                  |First host
;                  |Last host
; Syntax.........: _LanParameters([$IP, $Subnet])
; Parameters ....:
;
; Return values .:
; Author ........:
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================

Func _LanParameters($theIP1 = "", $sSubNet = "255.255.255.255", $Msg = 0)
    Static $TCP = TCPStartup()
    If $theIP1 = "" Then
        $theIP1 = TCPNameToIP(@ComputerName)
        $sSubNet = _GetSubnetMask($theIP1)
    ElseIf $sSubNet = "" Then
        $sSubNet = "255.255.255.255"
    EndIf
    If Not _isSNmask($sSubNet) Then ; it is not a 4 digit subnet
        If $sSubNet > 0 And $sSubNet < 33 Then ; is it a CIDR notation number? nr. of bits 1 to 32
            $sSubNet = _CIDR_To_Mask($sSubNet)
        Else
            Return SetError(4, 0, False) ; wrong mask
        EndIf
    EndIf

    Local $aLan = _GetLanParameters($theIP1, $sSubNet)
    Local $LanID[7][3]
    $LanID[0][0] = "IP Address       "
    $LanID[1][0] = "Netmask  "
    $LanID[2][0] = "Wildcard         "
    $LanID[3][0] = "Network Address  "
    $LanID[4][0] = "Broadcast Address"
    $LanID[5][0] = "First host       "
    $LanID[6][0] = "Last host        "
    For $i = 0 To 6
        $LanID[$i][1] = $aLan[$i][0]
        $LanID[$i][2] = _Convert_To_Binary($aLan[$i][1]) & "." & _Convert_To_Binary($aLan[$i][2]) & "." & _Convert_To_Binary($aLan[$i][3]) & "." & _Convert_To_Binary($aLan[$i][4])
    Next
    If $Msg Then MsgBox(0, "Lan IDs", $LanID[0][0] & @TAB & $LanID[0][2] & @TAB & $LanID[0][1] & @CRLF & _
            $LanID[1][0] & "( " & _Mask_To_CIDR($LanID[1][1]) & " ) " & @TAB & $LanID[1][2] & @TAB & $LanID[1][1] & @CRLF & _
            $LanID[2][0] & @TAB & $LanID[2][2] & @TAB & $LanID[2][1] & @CRLF & _
            $LanID[3][0] & @TAB & $LanID[3][2] & @TAB & $LanID[3][1] & @CRLF & _
            $LanID[4][0] & @TAB & $LanID[4][2] & @TAB & $LanID[4][1] & @CRLF & _
            $LanID[5][0] & @TAB & $LanID[5][2] & @TAB & $LanID[5][1] & @CRLF & _
            $LanID[6][0] & @TAB & $LanID[6][2] & @TAB & $LanID[6][1] & @CRLF)
    Return $LanID
EndFunc   ;==>_LanParameters

; #FUNCTION# ====================================================================================================================
; Name...........: _CIDR_To_Mask
; Description ...: transform a CIDR number (1 - 32) to the corresponding 4 digit mask
; Syntax.........: _CIDR_To_Mask($CIDR)
; Parameters ....: $CIDR a number from 1 to 32
; Return values .: a 4 bite corresponding subnet mask
; ===============================================================================================================================

Func _CIDR_To_Mask($sSubNet) ; From nr. of bit to 4 digit mask
    $sSubNet = StringLeft(StringLeft("11111111111111111111111111111111", $sSubNet) & "0000000000000000000000000000000", 32)
    $sSubNet = _Bin_To_Dec(StringLeft($sSubNet, 8)) & "." & _Bin_To_Dec(StringMid($sSubNet, 9, 8)) & "." & _Bin_To_Dec(StringMid($sSubNet, 17, 8)) & "." & _Bin_To_Dec(StringRight($sSubNet, 8))
    Return $sSubNet
EndFunc   ;==>_CIDR_To_Mask

; #FUNCTION# ====================================================================================================================
; Name...........: _Mask_To_CIDR
; Description ...: transform a 4 digit mask to the corresponding CIDR number (1 - 32)
; Syntax.........: _Mask_To_CIDR($SubnetMask)
; Parameters ....: $SubnetMask a 4 bite subnet mask
; Return values .: the corresponding CIDR
; ===============================================================================================================================

Func _Mask_To_CIDR($sSubNet) ; from 4 digit mask to nr. of bits
    If _isSNmask($sSubNet) Then
        Local $Digit = StringSplit($sSubNet, ".", 2)
        Return StringInStr(_Convert_To_Binary($Digit[0]) & _Convert_To_Binary($Digit[1]) & _Convert_To_Binary($Digit[2]) & _Convert_To_Binary($Digit[3]), "1", 0, -1)
    Else
        Return SetError(4, 0, False) ; wrong mask
    EndIf
EndFunc   ;==>_Mask_To_CIDR

; _GetSubnetMask
; #FUNCTION# ====================================================================================================================
; Name...........: _GetSubnetMask
; Description ...: given the local IP returns the related subnet mask (thanks to dragan)
;                  http://www.autoitscript.com/forum/topic/155078-how-to-easily-get-the-subnet-mask/?p=1120929
; Syntax.........: _GetSubnetMask($LocalIP)
; Parameters ....: $LocalIP IP of the local computer
; Return values .: the corresponding subnet mask
; ===============================================================================================================================

Func _GetSubnetMask($theIP) ; given the local IP returns the related subnet mask
    Local Const $tagIP_ADDRESS_STRING = "char IPAddress[16];"
    Local Const $tagIP_MASK_STRING = "char IPMask[16];"
    Local Const $tagIP_ADDR_STRING = "ptr Next;" & $tagIP_ADDRESS_STRING & $tagIP_MASK_STRING & "DWORD Context;"
    Local Const $tagIP_ADAPTER_INFO = "ptr Next; DWORD ComboIndex; char AdapterName[260];char Description[132]; UINT AddressLength; BYTE Address[8]; dword Index; UINT Type;" & _
            " UINT DhcpEnabled; ptr CurrentIpAddress; ptr IpAddressListNext; char IpAddressListADDRESS[16]; char IpAddressListMASK[16]; DWORD IpAddressListContext; " & _
            "ptr GatewayListNext; char GatewayListADDRESS[16]; char GatewayListMASK[16]; DWORD GatewayListContext; " & _
            "ptr DhcpServerNext; char DhcpServerADDRESS[16]; char DhcpServerMASK[16]; DWORD DhcpServerContext; " & _
            "int HaveWins; " & _
            "ptr PrimaryWinsServerNext; char PrimaryWinsServerADDRESS[16]; char PrimaryWinsServerMASK[16]; DWORD PrimaryWinsServerContext; " & _
            "ptr SecondaryWinsServerNext; char SecondaryWinsServerADDRESS[16]; char SecondaryWinsServerMASK[16]; DWORD SecondaryWinsServerContext; " & _
            "DWORD LeaseObtained; DWORD LeaseExpires;"
    Local $dll = DllOpen("Iphlpapi.dll")
    If @error Then Return SetError(8, @error, 0); <----------- error  'dll open: Iphlpapi.dll'
    Local $ret = DllCall($dll, "dword", "GetAdaptersInfo", "ptr", 0, "dword*", 0)
    If @error Then
        DllClose($dll)
        Return SetError(8, @error, 0); <----------- error  'dll call function: GetAdaptersInfo'
    EndIf
    Local $adapterBuffer = DllStructCreate("byte[" & $ret[2] & "]")
    Local $adapterBuffer_pointer = DllStructGetPtr($adapterBuffer)
    DllCall($dll, "dword", "GetAdaptersInfo", "ptr", $adapterBuffer_pointer, "dword*", $ret[2])
    If @error Then
        $adapterBuffer = ""
        $adapterBuffer_pointer = ""
        DllClose($dll)
        Return SetError(8, @error, 0); <----------- error 'dll call function: GetAdaptersInfo with adapter buffer pointer'
    EndIf
    Local $adapter = DllStructCreate($tagIP_ADAPTER_INFO, $adapterBuffer_pointer)
    Local $IPType = -1
    Local $FoundIt = False
    Local $retVal = ""
    Do ; -------------------- IP search --------------------
        $Ptr = DllStructGetPtr($adapter, "IpAddressListNext")
        Local $IPStruct, $Index = 0
        Local $allArray[1][3]
        Do
            ReDim $allArray[$Index + 1][3]
            $IPStruct = DllStructCreate($tagIP_ADDR_STRING, $Ptr)
            $allArray[$Index][0] = DllStructGetData($IPStruct, "IPAddress")
            $allArray[$Index][1] = DllStructGetData($IPStruct, "IPMask")
            $allArray[$Index][2] = DllStructGetData($IPStruct, "Context")
            $Ptr = DllStructGetData($IPStruct, "Next")
            $Index += 1
        Until $Ptr = 0
        For $i = 0 To UBound($allArray) - 1
            If $allArray[$i][0] <> $theIP Then ContinueLoop ; >-+
            $retVal = $allArray[$i][1] ;                        |
            $IPType = 0 ;                                       |
            $FoundIt = True ;                                   |
            ExitLoop ; if found do not search over              |
        Next ;                                          <-------+
        If $FoundIt Then ExitLoop ; >---------------------------+
        $Ptr = DllStructGetData($adapter, "Next") ;             |
        $adapter = DllStructCreate($tagIP_ADAPTER_INFO, $Ptr);  |
    Until @error ;                                              |
    ;                               <---------------------------+
    $adapterBuffer = ""
    $adapterBuffer_pointer = ""
    DllClose($dll)
    If Not $FoundIt Then Return SetError(3, 0, 0) ; IP not found <----------- error
    Return SetError(0, $IPType, $retVal) ; OK Return mask
EndFunc   ;==>_GetSubnetMask

Func _isIPaddr($sIPAddr) ; returns true if argument is a plausible IP address
    If Not StringRegExp($sIPAddr, "^((25[0-5]|2[0-4]\d|[01]?\d?\d)\.){3}(25[0-5]|2[0-4]\d|[01]?\d?\d)$") Then Return SetError(1, 0, False)
    Return True
EndFunc   ;==>_isIPaddr

Func _isSNmask($sSNmask) ; returns true if argument is a correct 4 digit network mask
    If Not StringRegExp($sSNmask, "^(((255\.){3}(255|254|252|248|240|224|192|128|0+))|((255\.){2}(255|254|252|248|240|224|192|128|0+)\.0)|((255\.)(255|254|252|248|240|224|192|128|0+)(\.0+){2})|((255|254|252|248|240|224|192|128|0+)(\.0+){3}))$") Then Return SetError(1, 0, False)
    Return True
EndFunc   ;==>_isSNmask

Func _Progress($aArgs)
    ; Func _Progress($ToDo, $Done, $Dummy1, $Dummy2, $Dummy3, $Dummy4)
    ; this will show the progress bar while scanning
    ; $_Percent = Int($Done / $ToDo * 100)
    $_Percent = Int($aArgs[1] / $aArgs[0] * 100)
    Static $_Progress = 0
    If Not $_Progress Then
        ProgressOn("Progress Meter", "Pinged address ", $aArgs[1] & "/" & $aArgs[0] & " ( 0 %)", -1, -1, 16)
        $_Progress = 1
    EndIf

    ProgressSet($_Percent, $aArgs[1] & "/" & $aArgs[0] & " ( " & $_Percent & " %)", "Pinged address " & $aArgs[2])

    If $_Percent = 100 Then
        ProgressSet(100, "Done", "Complete")
        Sleep(500)
        ProgressOff()
        $_Progress = 0
    EndIf
EndFunc   ;==>_Progress

Func _Convert_To_Binary($iNumber) ; from decimal to binary
    ; http://www.autoitscript.com/forum/topic/90056-decimal-to-binary-number-converter/?p=647505
    Local $sBinString = ""
    While $iNumber
        $sBinString = BitAND($iNumber, 1) & $sBinString
        $iNumber = BitShift($iNumber, 1)
    WEnd
    ; limit returned value to 8 bit 0 - 255
    Return StringRight("00000000" & $sBinString, 8)
EndFunc   ;==>_Convert_To_Binary

Func _Bin_To_Dec($BinNum) ; from binary to decimal
    Local $dec = 0
    For $i = 0 To StringLen($BinNum) - 1
        $dec += 2 ^ $i * StringMid($BinNum, StringLen($BinNum) - $i, 1)
    Next
    Return $dec
EndFunc   ;==>_Bin_To_Dec

; #FUNCTION# ====================================================================================================================
; Name...........: _FileReadToArray_mod
; Description ...: read a file to an array and if is passed a separator and a column number extract only that column (from a csv)
; Syntax.........: _FileReadToArray_mod($sFilePath, $delim = ";")
; Parameters ....: |$sFilePath  -   path and filename of the file to read
;                  |$delim      -   the character separator of the values in the csv
; Remarks .......: if the file is not a csv and contains only one IP per line then $delim is ignored
; Return values .: an 1D array containing the "IP" extracted from the $col column. First column is nr.0
; ===============================================================================================================================
; Func _FileReadColumnToArray($sFilePath, $delim = ";", $col = 0)
Func _FileReadToArray_mod($sFilePath, $delim = ";")
    ; this function is extracted, adapted and slightly modified from the _FileReadToArray() function in file.au3
    Local $aArray
    Local $hFile = FileOpen($sFilePath, 0); $FO_READ)
    If $hFile = -1 Then Return SetError(1, 0, 0);; unable to open the file
    ;; Read the file and remove any trailing white spaces
    Local $aFile = FileRead($hFile, FileGetSize($sFilePath))
    FileClose($hFile)
;~  $aFile = StringStripWS($aFile, 2)
    ; remove last line separator if any at the end of the file
    If StringRight($aFile, 1) = @LF Then $aFile = StringTrimRight($aFile, 1)
    If StringRight($aFile, 1) = @CR Then $aFile = StringTrimRight($aFile, 1)
    If StringInStr($aFile, @LF) Then
        $aArray = StringSplit(StringStripCR($aFile), @LF)
    ElseIf StringInStr($aFile, @CR) Then ;; @LF does not exist so split on the @CR
        $aArray = StringSplit($aFile, @CR)
    Else ;; unable to split the file
        If StringLen($aFile) Then
            Dim $aArray[2] = [1, $aFile] ; returns the whole file in one element
        Else
            Return SetError(2, 0, 0) ; File is empty
        EndIf
    EndIf

    ; now split 1D $aArray to 2D $aColumns according to delimiter

    Local $aColumns[$aArray[0]][1] ; create a new [2D] array with same nr. of lines of $aArray
    For $i = 1 To $aArray[0] ; scan all lines of the array
        $TempRow = StringSplit($aArray[$i], $delim, 2) ; split the line
        If UBound($TempRow) > UBound($aColumns, 2) Then ReDim $aColumns[$aArray[0]][UBound($TempRow)]
        For $ii = 0 To UBound($TempRow) - 1
            $aColumns[$i - 1][$ii] = $TempRow[$ii]
        Next
    Next
    Return $aColumns
EndFunc   ;==>_FileReadToArray_mod

Func _ExtractColumnFromArray($aArray, $col = 0)
    If 1 = UBound($aArray, 0) Then
        If $col = 0 Then
            Return $aArray ; already a single column array, send it back as is
        Else
            Return SetError(2, 0, -1) ; wrong column number
        EndIf
    EndIf
    If $col >= UBound($aArray, 2) Then Return SetError(2, 0, -1) ; wrong column number
    Local $aColumn[UBound($aArray)] ; create a new [1D] array
    For $i = 0 To UBound($aArray) - 1 ; scan all lines of the array
        $aColumn[$i] = $aArray[$i][$col]
    Next
    Return $aColumn
EndFunc   ;==>_ExtractColumnFromArray