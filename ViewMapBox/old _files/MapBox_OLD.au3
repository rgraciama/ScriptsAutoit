#include <GUIConstantsEx.au3>
#include <WinAPI.au3>
#include <windowsconstants.au3>
#include <Constants.au3>

Opt("MouseCoordMode", 0)

$pos = MouseGetPos()

$maxH_mapGUI = 620
$maxW_mapGUI = 600

$hGUI_map = GUICreate("Cajas Colorado",$maxW_mapGUI,$maxH_mapGUI,0,0)

;file ini
$file_ini = "iniBox.ini"

;MAPA
$pic_map = GUICtrlCreatePic("maps\Colorado.jpg",0,20,600,620)
GuiCtrlSetState(-1,$GUI_DISABLE)

;Imagenes Box
$pic_box0 = GUICtrlCreatePic("numbox\n0.jpg",XreadIniBox(0),YreadIniBox(0),16,16)
$pic_box1 = GUICtrlCreatePic("numbox\n1.jpg",XreadIniBox(1),YreadIniBox(1),16,16)
$pic_box2 = GUICtrlCreatePic("numbox\n2.jpg",XreadIniBox(2),YreadIniBox(2),16,16)
$pic_box3 = GUICtrlCreatePic("numbox\n3.jpg",XreadIniBox(3),YreadIniBox(3),16,16)
$pic_box4 = GUICtrlCreatePic("numbox\n4.jpg",XreadIniBox(4),YreadIniBox(4),16,16)
$pic_box5 = GUICtrlCreatePic("numbox\n5.jpg",XreadIniBox(5),YreadIniBox(5),16,16)
$pic_box6 = GUICtrlCreatePic("numbox\n6.jpg",XreadIniBox(6),YreadIniBox(6),16,16)
$pic_box7 = GUICtrlCreatePic("numbox\n7.jpg",XreadIniBox(7),YreadIniBox(7),16,16)
$pic_box8 = GUICtrlCreatePic("numbox\n8.jpg",XreadIniBox(8),YreadIniBox(8),16,16)
$pic_box9 = GUICtrlCreatePic("numbox\n9.jpg",XreadIniBox(9),YreadIniBox(9),16,16)

Func Check()
	Local $cursor, $text
		$cursor = _WinAPI_GetCursorInfo()
		$text = "Was the operation sucessful? " & $cursor[0] & @LF
		$text &= "Is the cursor showing? " & $cursor[1] & @LF & @LF
		$text &= "Cursor Handle: " & $cursor[2] & @LF
		$text &= "X Coordinate: " & $cursor[3] & @LF
		$text &= "Y Coordinate: " & $cursor[4]


	ToolTip($text,0,0,"")
EndFunc
;iniBox read1
Func XreadIniBox($num)
	$x_box = iniRead($file_ini,"Coor","x_box" & $num,"Error")
	return $x_box
EndFunc

Func YreadIniBox($num)
	$y_box = iniRead($file_ini,"Coor","y_box" & $num,"Error")
	return $y_box
EndFunc

;iniBox write
Func XYwriteIniBox($num, $pos)
	;X
	iniWrite($file_ini, "Coor","x_box" & $num,$pos[0]-8)
	;Y
	iniWrite($file_ini, "Coor","y_box" & $num,$pos[1]-8)
EndFunc

;Hotkey's
HotKeySet("^0", "selectBox")
HotKeySet("^1", "selectBox")
HotKeySet("^2", "selectBox")
HotKeySet("^3", "selectBox")
HotKeySet("^4", "selectBox")
HotKeySet("^5", "selectBox")
HotKeySet("^6", "selectBox")
HotKeySet("^7", "selectBox")
HotKeySet("^8", "selectBox")
HotKeySet("^9", "selectBox")

;Mueve imagen box: entrada objeto caja y posicion
Func getPosBox($box, $pos)
	GUICtrlSetPos($box, $pos[0]-8, $pos[1]-8)
EndFunc

Func fixPos($pos)
	If $pos[0] < 0 Then
		$pos[0] = 0
	ElseIf $pos[0] > $maxW_mapGUI Then
		$pos[0] = $maxW_mapGUI
	EndIf
	If $pos[1] < 20 Then
		$pos[1] = 20
	ElseIf $pos[1] > $maxH_mapGUI Then
		$pos[1] = $maxH_mapGUI
	EndIf
	return $pos
EndFunc

;Selecciona caja segun hotkey y llama a funcion getPosBox(caja, posicion)
Func selectBox()

	If WinActive("Cajas Colorado") Then
		$pos = fixPos($pos)
		Switch @HotKeyPressed
			Case "^0"

				getPosBox($pic_box0,$pos)
				XYwriteIniBox(0, $pos)
			Case "^1"
				getPosBox($pic_box1, $pos)
				XYwriteIniBox(1, $pos)
			Case "^2"
				getPosBox($pic_box2, $pos)
				XYwriteIniBox(2, $pos)
			Case "^3"
				getPosBox($pic_box3, $pos)
				XYwriteIniBox(3, $pos)
			Case "^4"
				getPosBox($pic_box4, $pos)
				XYwriteIniBox(4, $pos)
			Case "^5"
				getPosBox($pic_box5, $pos)
				XYwriteIniBox(5, $pos)
			Case "^6"
				getPosBox($pic_box6, $pos)
				XYwriteIniBox(6, $pos)
			Case "^7"
				getPosBox($pic_box7, $pos)
				XYwriteIniBox(7, $pos)
			Case "^8"
				getPosBox($pic_box8, $pos)
				XYwriteIniBox(8, $pos)
			Case "^9"
				getPosBox($pic_box9, $pos)
				XYwriteIniBox(9, $pos)
		EndSwitch
	EndIf
EndFunc

GUISetState(@SW_SHOW)

While 1
	If WinActive("Cajas Colorado") Then
		$pos = GUIGetCursorInfo("Cajas")
	EndIF
	;check()
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			Exit
		Case $pic_box0
			MsgBox(1,"hola","asd")
	EndSwitch
WEnd