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
_GUICtrlListView_BeginUpdate($listview)
_GUICtrlListView_AddArray($listview, $IPlist) ; fill ListView
_GUICtrlListView_EndUpdate($listview)

;While 1
; perform Pings and update ListView by the "_refresh" callback function
$aFinalResult = _nPing($IPlist, 1, 0, 0, "_refresh")
_ArrayDisplay($aFinalResult) ; this is the result of all the pings

; Now Write a sample of data to a file on disk:
; ---------------------------------------------
$hFile = FileOpen("PingResults.csv", 2) ; $FO_OVERWRITE (2) = Write mode (erase previous contents)
For $i = 1 To $aFinalResult[0][0]
    $sResult = $aFinalResult[$i][0] & "," ; address of device
    If $aFinalResult[$i][2] <> -1 Then
        $sResult &= "OnLine"
    Else
        $sResult &= "OffLine"
    EndIf

    FileWriteLine($hFile, $sResult)
Next

FileFlush($hFile)
FileClose($hFile)

 ShellExecute("PingResults.csv") ; open the csv (with excel)

; WEnd

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