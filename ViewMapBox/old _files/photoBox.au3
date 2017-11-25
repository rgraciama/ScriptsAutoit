#include <ScreenCapture.au3>

Opt("CaretCoordMode", 2)

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
	_ScreenCapture_Capture("C:\Users\Raul\Dropbox\Cajas" & "\" & $name & ".jpg", 982, 231, 1783, 715)
EndFunc
;Parte de abajo caja
Func photoBoxNum2($name)
	_ScreenCapture_Capture("C:\Users\Raul\Dropbox\Cajas" & "\" & $name & ".jpg", 982, 398, 1783, 715)
EndFunc

While 1

Wend