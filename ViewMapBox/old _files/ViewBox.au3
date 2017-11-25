#include <GUIConstantsEx.au3>

$hGUI = GUICreate("Cajas",500,820,@DesktopWidth + 770,0)
$pic_box = GUICtrlCreatePic("C:\Users\Raul\Dropbox\Cajas\1.1.jpg",0,20,500,485)
$pic_box2 = GUICtrlCreatePic("C:\Users\Raul\Dropbox\Cajas\1.2.jpg",0,500,500,318)
;$pic_map = GUICtrlCreatePic("C:\Users\Raul\Dropbox\Cajas\colorado.jpg",0,20,500,485)

$b_box1 = GUICtrlCreateButton("1", 0,0, 20,20)
$b_box2 = GUICtrlCreateButton("2", 20,0, 20,20)
$b_box3 = GUICtrlCreateButton("3", 40,0, 20,20)
$b_box4 = GUICtrlCreateButton("4", 60,0, 20,20)
$b_box5 = GUICtrlCreateButton("5", 80,0, 20,20)

$b_map = GUICtrlCreateButton("M", 480,0, 20,20)

GUISetState(@SW_SHOW, "Hola")

Func loadPicBox($name)
	$name1 = $name & ".1"
	$name2 = $name & ".2"
	GUICtrlSetImage($pic_box, "C:\Users\Raul\Dropbox\Cajas\" & $name1 & ".jpg", 22)
	GUICtrlSetImage($pic_box2, "C:\Users\Raul\Dropbox\Cajas\" & $name2 & ".jpg", 22)
EndFunc

Func coloradoMap()
	GUICtrlSetImage($pic_box, "C:\Users\Raul\Dropbox\Cajas\colorado.jpg", 22)
EndFunc

While 1
    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE
            Exit
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
		Case $b_map
			coloradoMap()
	EndSwitch
	;Sleep(70)
WEnd
