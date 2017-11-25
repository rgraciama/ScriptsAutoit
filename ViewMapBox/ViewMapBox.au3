#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=lockbox.ico
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <GUIConstantsEx.au3>
#include <WinAPI.au3>
#include <windowsconstants.au3>
#include <Constants.au3>
#include <ScreenCapture.au3>

Opt("CaretCoordMode", 2)
Opt("MouseCoordMode", 0)

Global $pos = MouseGetPos()


Global $maxH_mapGUI = 900
Global $maxW_mapGUI = 811

Global $isOne = True ;Important var to change GUI

;-----------------------------------------------------
; GUI MAPA
;-----------------------------------------------------
$hGUI_map = GUICreate("Cajas Mapa",$maxW_mapGUI,$maxH_mapGUI,@DesktopWidth-@DesktopWidth,0)

;file ini
$file_ini = "iniBox.ini"

;MAPA
$pic_map = GUICtrlCreatePic("maps\Colorado.jpg",0,20,$maxW_mapGUI,$maxH_mapGUI)
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
;END GUI MAPA
;------------------------------------------------------

;------------------------------------------------------
; GUI BOXES
;------------------------------------------------------
Global $hGUI_box = GUICreate("Cajas",600,820,@DesktopWidth-@DesktopWidth,0)
$pic_box = GUICtrlCreatePic("itembox\blank.jpg",0,20,600,485)
$pic_sub_box = GUICtrlCreatePic("itembox\blank_sub.jpg",0,500,600,318)

$b_box0 = GUICtrlCreateButton("0", 0,0, 20,20)
$b_box1 = GUICtrlCreateButton("1", 20,0, 20,20)
$b_box2 = GUICtrlCreateButton("2", 40,0, 20,20)
$b_box3 = GUICtrlCreateButton("3", 60,0, 20,20)
$b_box4 = GUICtrlCreateButton("4", 80,0, 20,20)
$b_box5 = GUICtrlCreateButton("5", 100,0, 20,20)
$b_box6 = GUICtrlCreateButton("6", 120,0, 20,20)
$b_box7 = GUICtrlCreateButton("7", 140,0, 20,20)
$b_box8 = GUICtrlCreateButton("8", 160,0, 20,20)
$b_box9 = GUICtrlCreateButton("9", 180,0, 20,20)

$b_map = GUICtrlCreateButton("M", 580,0, 20,20)
;END GUI MAPA
;------------------------------------------------------

;------------------------------------------------------
; FUNCIONES PARA GUI CAJAS
;------------------------------------------------------
Func loadPicBox($name)
	$name1 = $name & ".1"
	$name2 = $name & ".2"
	GUICtrlSetImage($pic_box, "itembox\" & $name1 & ".jpg", 22)
	GUICtrlSetImage($pic_sub_box, "itembox\" & $name2 & ".jpg", 22)
EndFunc

Func coloradoMap()
	changeGUI()
EndFunc
; END FUNCIONES GUI CAJAS
;-----------------------------------------------------

;-----------------------------------------------------
; photoBox funciones
;-----------------------------------------------------
Func photoBox()
	Switch @HotKeyPressed
		Case "!0"
            photoBoxNum("0.1")
		Case "^!0"
            photoBoxNum2("0.2")
        Case "!1"
            photoBoxNum("1.1")
		Case "^!1"
            photoBoxNum2("1.2")
        Case "!2"
            photoBoxNum("2.1")
		Case "^!2"
            photoBoxNum2("2.2")
        Case "!3"
            photoBoxNum("3.1")
		Case "^!3"
            photoBoxNum2("3.2")
		Case "!4"
            photoBoxNum("4.1")
		Case "^!4"
            photoBoxNum2("4.2")
		Case "!5"
            photoBoxNum("5.1")
		Case "^!5"
            photoBoxNum2("5.2")
		Case "!6"
            photoBoxNum("6.1")
		Case "^!6"
            photoBoxNum2("6.2")
		Case "!7"
            photoBoxNum("7.1")
		Case "^!7"
            photoBoxNum2("7.2")
		Case "!8"
            photoBoxNum("8.1")
		Case "^!8"
            photoBoxNum2("8.2")
		Case "!9"
            photoBoxNum("9.1")
		Case "^!9"
            photoBoxNum2("9.2")
    EndSwitch
EndFunc

;Parte de arriba caja
Func photoBoxNum($name)
	_ScreenCapture_Capture("itembox" & "\" & $name & ".jpg", 982, 231, 1783, 715)
	$name = StringLeft ( $name, 1 )
	$hola = FileCopy ("itembox\blank_sub.jpg", "itembox\" & $name & ".2.jpg",1)
EndFunc
;Parte de abajo caja
Func photoBoxNum2($name)
	_ScreenCapture_Capture("itembox" & "\" & $name & ".jpg", 982, 398, 1783, 715)
EndFunc

;END funciones photobox
;-----------------------------------------------------

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

	If WinActive("Cajas Mapa") Then

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

;ChangeGUI
Func changeGUI()
	If $isOne Then
		GUISetState(@SW_HIDE, "Cajas Mapa")
		GUISetState(@SW_DISABLE, $hGUI_map)
		GUISetState(@SW_ENABLE, $hGUI_box)
		GUISwitch($hGUI_box)
		GUISetState(@SW_SHOW, "Cajas")
		$isOne = Not $isOne
	Else
		GUISetState(@SW_HIDE, "Cajas")
		GUISetState(@SW_DISABLE, $hGUI_box)
		GUISetState(@SW_ENABLE, $hGUI_map)
		GUISwitch($hGUI_map)
		GUISetState(@SW_SHOW, "Cajas Mapa")
		$isOne = Not $isOne
	EndIf
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
HotKeySet("^º", "changeGUI")

;photoBox
HotKeySet("!0", "photoBox")
HotKeySet("^!0", "photoBox")

HotKeySet("!1", "photoBox")
HotKeySet("^!1", "photoBox")

HotKeySet("!2", "photoBox")
HotKeySet("^!2", "photoBox")

HotKeySet("!3", "photoBox")
HotKeySet("^!3", "photoBox")

HotKeySet("!4", "photoBox")
HotKeySet("^!4", "photoBox")

HotKeySet("!5", "photoBox")
HotKeySet("^!5", "photoBox")

HotKeySet("!6", "photoBox")
HotKeySet("^!6", "photoBox")

HotKeySet("!7", "photoBox")
HotKeySet("^!7", "photoBox")

HotKeySet("!8", "photoBox")
HotKeySet("^!8", "photoBox")

HotKeySet("!9", "photoBox")
HotKeySet("^!9", "photoBox")
;end hotkeys photos

GUISetState(@SW_DISABLE, $hGUI_box)
GUISetState(@SW_ENABLE, $hGUI_map)
GUISwitch($hGUI_map)
GUISetState(@SW_SHOW, "Cajas Mapa")

While 1
	If WinActive("Cajas Mapa") Then
		$pos = GUIGetCursorInfo("Cajas Mapa")
		;MsgBox(0,"","selectBox")
	EndIF

	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			Exit
		Case $pic_box0 ;CAJAS MAPA
			changeGUI()
			loadPicBox(0)
		Case $pic_box1
			changeGUI()
			loadPicBox(1)
		Case $pic_box2
			changeGUI()
			loadPicBox(2)
		Case $pic_box3
			changeGUI()
			loadPicBox(3)
		Case $pic_box4
			changeGUI()
			loadPicBox(4)
		Case $pic_box5
			changeGUI()
			loadPicBox(5)
		Case $pic_box6
			changeGUI()
			loadPicBox(6)
		Case $pic_box7
			changeGUI()
			loadPicBox(7)
		Case $pic_box8
			changeGUI()
			loadPicBox(8)
		Case $pic_box9
			changeGUI()
			loadPicBox(9)
		Case $b_box0 ;INTERIOR CAJAS
			loadPicBox(0)
		Case $b_box1
			loadPicBox(1)
		Case $b_box2
			loadPicBox(2)
		Case $b_box3
			loadPicBox(3)
		Case $b_box4
			loadPicBox(4)
		Case $b_box5
			loadPicBox(5)
		Case $b_box6
			loadPicBox(6)
		Case $b_box7
			loadPicBox(7)
		Case $b_box8
			loadPicBox(8)
		Case $b_box9
			loadPicBox(9)
		Case $b_map
			coloradoMap()
	EndSwitch
WEnd