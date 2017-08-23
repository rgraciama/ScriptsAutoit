; this is to ping continuously a list of IP addresses, get and display ping result "live"
; it simulates the dos "ping -t" command but performed simultaneously on many IP
; presenting the results in a ListView highlighting not responding devices with a red box

#include <GUIConstantsEx.au3>
#include <Array.au3>
#include <GuiListView.au3>
#include <GuiImageList.au3>
#include <ListviewConstants.au3>

#include 'MultiPing.au3' ; <-- take this from the following link:
; http://www.autoitscript.com/forum/topic/156395-versatile-multi-ping

Opt("GUIOnEventMode", 1)
HotKeySet("{esc}", "_button1")

Local $Win_X = 600, $Win_Y = 600 ; dimension of window
$PingGui = GUICreate("IP addresses monitor", $Win_X, $Win_Y, -1, -1)
GUISetOnEvent($GUI_EVENT_CLOSE, "_button1", $PingGui)
$listview = GUICtrlCreateListView("", 10, 10, $Win_X - 20, $Win_Y - 40)
GUICtrlSetFont(-1, 6)
GUICtrlSetStyle($listview, $LVS_ICON) ; + $LVS_NOLABELWRAP)

; Generate colored square images
$hImage = _GUIImageList_Create(16, 16)
_GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap($listview, 0xFFFF00, 16, 16)) ; yellow
_GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap($listview, 0xFF0000, 16, 16)) ; red
_GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap($listview, 0x00FF00, 16, 16)) ; green

_GUICtrlListView_SetImageList($listview, $hImage, 0)

$button1 = GUICtrlCreateButton("Exit", 10, $Win_Y - 25, $Win_X - 20, 20)
GUICtrlSetTip(-1, "End of program")
GUICtrlSetOnEvent(-1, "_button1")
GUISetState(@SW_SHOW)

$IPlist = _FileReadToArray_mod(".\IP_List.txt") ; Reads text file for list of IP's
;
; the above command, it loads in the $IPlist array the values contained in the file IP_List.txt
; values in the file should be separated by a semicolon, something like in the following example:
;
; hostname1;192.168.0.1
; hostname2;192.168.0.5
; hostnameX;10.59.7.200
; etc....
;
;  if values in the file are not separated by a semicolon, but another char is used, for example a comma,
;  then just pass it as second parameter of the function: $IPlist = _FileReadToArray_mod(".\IP_List.txt", ",")
;
_GUICtrlListView_BeginUpdate($listview)
_GUICtrlListView_AddArray($listview, $IPlist) ; fill ListView
_GUICtrlListView_EndUpdate($listview)

While 1 ; continuously ping addresses of the previously loaded file (IP_List.txt)
    Sleep(10)
    ;
    ;        $IPlist is the array loaded with all the IP to be pinged (a 2d array in this case)
    ;        |
    ;        |      1 means the IP are in the second column of the $IPlist array (first colun is nr. 0)
    ;        |      |
    ;        |      |  +-->  0 means return back an array loaded with results from all pinged addresses (responding and not responding)
    ;        |      |  |     if you use 1 then only responding addresses are loaded in the returned array [default]
    ;        |      |  |     if you use 2 then only NOT responding addresses are loaded in the returned array
    ;        |      |  |     In this case we do not need an  array to be returned, we only need to perform all pings and pass results
    ;        |      |  |     directly (on the fly) to the "_refresh" callback function that will refresh the listview
    ;        |      |  |
    ;        |      |  |  0 means NO lookup name resolution must be performed
    ;        |      |  |  |
    ;        |      |  |  |   +--> this is the callback function to be called for each pinged address each time the ping has finished
    ;        |      |  |  |   |    (see the MultiPing.au3 file for info on all passed params)
    ;        |      |  |  |   |    6 parameters are passed to this function, but only 2 are used by the called function in this case:
    ;        |      |  |  |   |    [4] roundtrip of the responding ping or -1 if IP is down
    ;        |      |  |  |   |    [5] Index (position) of this IP within the caller's passed array
    ;        |      |  |  |   |
    ;        v      v  v  v   v
    _nPing($IPlist, 1, 0, 0, "_refresh")
    ;
WEnd

Func _refresh($Params) ; this receive ping results and displays them in the ListView
    _GUICtrlListView_SetItemImage($listview, $Params[5], 0) ; set colour to Yellow
    Sleep(50) ; a little wait
    If $Params[4] = -1 Then ; Device not responding to ping
        _GUICtrlListView_SetItemImage($listview, $Params[5], 1) ; set colour to RED
        _GUICtrlListView_EnsureVisible($listview, $Params[5]) ; Position view to this item
    Else ; Device responds to ping
        _GUICtrlListView_SetItemImage($listview, $Params[5], 2) ; set colour to GREEN
    EndIf
EndFunc   ;==>_refresh

Func _button1() ; Button 1 clicked
    Exit
EndFunc   ;==>_button1