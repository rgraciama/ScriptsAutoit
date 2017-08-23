#include 'MultiPing.au3'
#include <array.au3>

MsgBox(0, "Hello", "The _nPing() function will ping ranges of IP addresses" & @CRLF & @CRLF & _
        "if called without arguments, it will try to detect your LAN parameters" & @CRLF & _
        "and then will ping all your LAN addresses, returninig a list of responding IP." & @CRLF & @CRLF & _
        "First  a detection of the LAN is performed and result displayed" & @CRLF & @CRLF & _
        "Press OK to detect:")

$lan = _LanParameters("", "", 1) ; with the first 2 argument blank, will detect local LAN
;                                     the third parameter 1 means show results

MsgBox(0, "Hello", "OK, now the full IP range will be pinged." & @CRLF & "In this example only the addresses of responding devices" & @CRLF & _
        "will be returned in the array (default)," & @CRLF & _
        "but the function can also return:" & @CRLF & _
        " 0 the whole list of IPs" & @CRLF & _
        " 1 only responding IPs" & @CRLF & _
        " 2 only not responding IPs" & @CRLF & @CRLF & _
        "Press OK to ping from IP " & $lan[5][1] & " to IP " & $lan[6][1])

; simplest way to use: without parameters
; will scan all your local LAN
; and display only responding IP
Local $Result = _nPing()
If @error Then MsgBox(0, "", "@error " & @error)
_ArrayDisplay($Result)

MsgBox(0, "", "Another way to use is to read a list of IP from a file (csv or single column)" & @CRLF & _
        "into an array and pass the array to the function" & @CRLF & _
        "if the array is 1D then is passed as is" & @CRLF & _
        "if the array is 2D (because a csv was read) the first column is passed," & @CRLF & _
        "but if you want to pass another column of the 2D array then" & @CRLF & _
        "just pass the column number (zero based) as second parameter (first column is 0)" & @CRLF & _
        "In this example the IP are in column 1" & @CRLF & @CRLF & _
        "Press OK to read the file")

; read the file in an array
; use the ";" as fields separator
$IPlist = _FileReadToArray_mod(".\IP_List.txt", ";")
If Not @error Then
    _ArrayDisplay($IPlist, "Data read from file") ; show array content
    $Result = _nPing($IPlist, 1); pass the second column to the function
    If @error Then MsgBox(0, "", "@error " & @error)
    _ArrayDisplay($Result) ; display the result of the pings
Else
    MsgBox(0, "", "@error " & @error)
EndIf