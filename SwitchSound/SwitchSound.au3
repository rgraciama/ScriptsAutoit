#Region
#AutoIt3Wrapper_Icon=Sound.ico
#EndRegion
; =================================================
; Switch between position devices.
; Reads conf.ini
; $sDevice1 = Device1 position
; $sNameDevice1 = The name of the device
; $sReady = text to say ready in your language
; $sWindowName = App window name
; =================================================
Local $sWindowName = IniRead(@ScriptDir & "\conf.ini", "Text", "WindowName", "Sound")
Local $sReady = IniRead(@ScriptDir & "\conf.ini", "Text", "Ready", "Ready")

Local $sDevice1 = IniRead(@ScriptDir & "\conf.ini", "Position", "Device1", 0)
Local $sDevice2 = IniRead(@ScriptDir & "\conf.ini", "Position", "Device2", 2)

Global $sNameDevice1 = IniRead(@ScriptDir & "\conf.ini", "NameDevice", "Name1", "Realtek High Definition Audio")
Global $sNameDevice2 = IniRead(@ScriptDir & "\conf.ini", "NameDevice", "Name2", "4- USB Sound Device")

Run("C:\Windows\System32\control.exe mmsys.cpl")

WinWaitActive($sWindowName)

Local $posDevice1 = ControlListView($sWindowName, "", 1000, "FindItem", $sNameDevice1, 1)
local $posDevice2 = ControlListView($sWindowName, "", 1000, "FindItem", $sNameDevice2, 1)

If ($sReady=ControlListView ($sWindowName, "", 1000, "GetText", $posDevice1, 2)) Then
	ControlListView ($sWindowName, "", 1000, "Select", $posDevice1) ;Auricular
Else
	ControlListView ($sWindowName, "", 1000, "Select", $posDevice2) ;Auricular
EndIf
ControlClick($sWindowName, "", 1002)

#cs
If ControlListView ($sWindowName, "", 1000, "GetText", $sDevice1, 2) <> $sReady Then
	ControlListView ($sWindowName, "", 1000, "Select", $sDevice2) ;Auricular
	ControlClick($sWindowName, "", 1002)
Else
	ControlListView ($sWindowName, "", 1000, "Select", $sDevice1) ;Altavoz
	ControlClick($sWindowName, "", 1002)
EndIf
#ce

WinClose($sWindowName)