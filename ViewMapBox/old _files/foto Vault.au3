#include <ScreenCapture.au3>

Opt("CaretCoordMode", 2)

$yeah = "sol"

HotKeySet("^1", "prueba(" & $yeah & ")")
#cs
HotKeySet("^�1", photoBox2("1.2"))

HotKeySet("^2", "photoBox(2)")
HotKeySet("^�2", photoBox2("2.2"))

HotKeySet("^3", photoBox("3.1"))
HotKeySet("^�3", photoBox2("3.2"))

HotKeySet("^4", photoBox("4.1"))
HotKeySet("^�4", photoBox2("4.2"))

HotKeySet("^5", photoBox("5.1"))
HotKeySet("^�5", photoBox2("5.2"))
#ce

Func prueba($text)
	MsgBox(1,"hola", $text)
EndFunc

Func photoBox($num)
	_ScreenCapture_Capture("C:\Users\Raul\Dropbox\Cajas" & "\" & $num & ".jpg", 982, 231, 1783, 715)
EndFunc

Func photoBox2($num)
	_ScreenCapture_Capture("C:\Users\Raul\Dropbox\Cajas" & "\" & $num & ".jpg", 982, 398, 1783, 715)
EndFunc

While 1

WEnd