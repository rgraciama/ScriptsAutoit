#Region
#AutoIt3Wrapper_Icon=Sound.ico
#EndRegion
; =================================================
; Switch entre mis dos tipos de reproductores.
; Altavoz posici�n=0 y Auricular=2.
; =================================================
Run("C:\Windows\System32\control.exe mmsys.cpl")

WinWaitActive("Sonido")

If ControlListView ( "Sonido", "", 1000, "GetText", 0, 2 )<>"Listo" Then
	ControlListView ( "Sonido", "", 1000, "Select", 2) ;Auricular
	ControlClick("Sonido", "", 1002)
Else
	ControlListView ( "Sonido", "", 1000, "Select", 0) ;Altavoz
	ControlClick("Sonido", "", 1002)
EndIf

WinClose("Sonido")