#Region
#AutoIt3Wrapper_Icon=Sound.ico
#EndRegion
; =================================================
; Switch between position devices.
; Reads conf.ini
; $sDevice1 = Device1 position
; $sReady = text to say ready in your language
; $sWindowName = App window name
; =================================================
Local $sWindowName = IniRead(@ScriptDir & "\conf.ini", "Text", "WindowName", "Sound")
Local $sReady = IniRead(@ScriptDir & "\conf.ini", "Text", "Ready", "Ready")

Local $sDevice1 = IniRead(@ScriptDir & "\conf.ini", "Position", "Device1", 0)
Local $sDevice2 = IniRead(@ScriptDir & "\conf.ini", "Position", "Device2", 2)

Run("C:\Windows\System32\control.exe mmsys.cpl")

WinWaitActive($sWindowName)

If ControlListView ($sWindowName, "", 1000, "GetText", $sDevice1, 2 )<>"Listo" Then
	ControlListView ($sWindowName, "", 1000, "Select", $sDevice2) ;Auricular
	ControlClick($sWindowName, "", 1002)
Else
	ControlListView ($sWindowName, "", 1000, "Select", $sDevice1) ;Altavoz
	ControlClick($sWindowName, "", 1002)
EndIf

WinClose($sWindowName)