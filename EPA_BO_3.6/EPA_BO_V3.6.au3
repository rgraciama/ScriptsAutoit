#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=EPA_BO.ico
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_Description=EPA BO
#AutoIt3Wrapper_Res_Fileversion=1.1.0.0
#AutoIt3Wrapper_Res_LegalCopyright=CopyLeft
#AutoIt3Wrapper_Res_Field=|Raul Gracia Maiques
#AutoIt3Wrapper_Res_Field=|Email: r.gracia.maiques@gmail.com
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <filesToString.au3>
#include <IE.au3>
#include <makeBuildHtml.au3>
#include <timer.au3>
#include <makeCounterHtml.au3>
#include <makeHelpHtml.au3>

$list = ProcessList(@ScriptName)
if $list[0][0]>1 Then
	Msgbox(4096,"Info","The App is running! Try to use (Control+Shift+>)")
	Exit
EndIf

$isOK = False ;Var used for the timer

$version = "EPA_BO_V3.5"
Global $height = 350
Global $width = 380
Global $isOne = True ;Important var to change GUI

Global $hGUI = GUICreate("Main",$width,$height, 10, 10,$WS_POPUP,$WS_EX_TOPMOST)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)

GUICtrlSetState(-1, $GUI_DISABLE)

WinSetTrans($hGUI,"",130)

$hHide_Button = GUICtrlCreateButton("", 300, 0, 20, 20)
GUICtrlSetBkColor(-1, 0x00FF00)
$hExit_Button = GUICtrlCreateButton("X", 360, 0, 20, 20)
GUICtrlSetFont(-1,10,400,-1,"Calibri",-1)
GUICtrlSetBkColor(-1, 0xff0000)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
$hMin_Button = GUICtrlCreateButton("_", 320, 0, 20, 20)
GUICtrlSetBkColor(-1, 0xFFFF00)
$hTime_Button = GUICtrlCreateButton("ON", 240, 0, 40, 20)
GUICtrlSetBkColor(-1, 0xFFFFFF)
GUICtrlSetFont(-1,10,400,-1,"Calibri",-1)
$hHelp_Button = GUICtrlCreateButton("?", 340, 0, 20, 20)
GUICtrlSetBkColor(-1, 0x0000FF)
GUICtrlSetFont(-1,10,400,-1,"Calibri",-1)

_IEErrorHandlerRegister()
Global $oIEZerg = _IECreateEmbedded()   ;creo el control insertado IE.
Global $oIETerran = _IECreateEmbedded()   ;creo el control insertado IE.
Global $oIEProtoss = _IECreateEmbedded()   ;creo el control insertado IE.
Global $oIECounter = _IECreateEmbedded() ;I build the GUI to insert IE



;TABULADORES
$TabRaces = GUICtrlCreateTab(0, 0, $width, $height,$WS_TABSTOP,0)
;GUICtrlSetBkColor(-1, 0x00FF00)
;GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
;--------------
;TAB ZERG
GUICtrlCreateTabItem("Zerg")
; COMBO 1
$cZerg = GUICtrlCreateCombo(firstFileToString("Zerg"), 10, 20, 200, 100)
GUICtrlSetData(-1, arrayFilesToString("Zerg"), firstFileToString("Zerg")) ; adiciona otros item
$lZerg = GUICtrlCreateObj($oIEZerg, 5, 45, $width-10, $height-50)   ;creo el control insertado IE.
;$lZerg = GUICtrlCreateLabel("try", 10,45,350, 300,-1) ;$WS_VSCROLL)
;GUICtrlSetFont(-1,14,400,-1,"Calibri",-1)
;GUICtrlSetColor(-1, 0xff0000)
;--------------
;TAB TERRAN
GUICtrlCreateTabItem("Terran")
; COMBO
$cTerran = GUICtrlCreateCombo(firstFileToString("Terran"), 10, 20, 200, 100)
GUICtrlSetData(-1, arrayFilesToString("Terran"), firstFileToString("Terran")) ; adiciona otros item
;$lTerran = GUICtrlCreateLabel("try", 10,45,350, 320)
$lTerran = GUICtrlCreateObj($oIETerran, 5, 45, $width-10, $height-50)   ;creo el control insertado IE.
;GUICtrlSetFont(-1,14,400,-1,"Calibri",-1)
;GUICtrlSetColor(-1, 0xff0000)
;--------------
;TAB PROTOSS
$cProtoss = GUICtrlCreateTabItem("Protoss")
; COMBO
$cProtoss = GUICtrlCreateCombo(firstFileToString("Protoss"), 10, 20, 200, 100)
GUICtrlSetData(-1, arrayFilesToString("Protoss"), firstFileToString("Protoss")) ; adiciona otros item
$lProtoss = GUICtrlCreateObj($oIEProtoss, 5, 45, $width-10, $height-50)   ;creo el control insertado IE.
;--------------

;--------------------------
;GUI DE COUNTERS
;--------------------------
Global $hGUI2 = GUICreate("Counter",$width*2+20,$height*2+30,10, 10,$WS_POPUP,$WS_EX_TOPMOST)

GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)

WinSetTrans($hGUI2,"",130)

$lCounter = GUICtrlCreateObj($oIECounter, 0, 0,$width*2, $height*2+30)
$hBack_Button = GUICtrlCreateButton("<", $width*2, 0, 20, 60)
GUICtrlSetBkColor(-1, 0x0000FF)
$hTerran_Button = GUICtrlCreateButton("T", $width*2, 60, 20, 60)
GUICtrlSetBkColor(-1, 0xFF0000)
$hZerg_Button = GUICtrlCreateButton("Z", $width*2, 120, 20, 60)
GUICtrlSetBkColor(-1, 0xFF00FF)
$hProtoss_Button = GUICtrlCreateButton("P", $width*2, 180, 20, 60)
GUICtrlSetBkColor(-1, 0xFFFF00)
;_IENavigate($oIECounter, GetReadHtmlNew())
;---------------------------

;--------------
;SELECT TAB RACE
;--------------
Func selectRace()
	$selTabRace = GUICtrlRead($TabRaces)
	Select
		Case $selTabRace = 0
			$race = "Zerg"
			$cRace = GUICtrlRead($cZerg)
			;GUICtrlSetData($lZerg, GetReadFile($race, $cRace)) ;v1
			;_IENavigate($oIEZerg, GetReadHtml($race, $cRace)) ;v2
			makeBuildHtml($race, $cRace)
			_IENavigate($oIEZerg, GetReadHtmlNew())
			FileDelete("copycurr.html")
		Case $selTabRace = 1
			$race = "Terran"
			$cRace = GUICtrlRead($cTerran)
			;GUICtrlSetData($lTerran, GetReadFile($race, $cRace)) ;v1
			;_IENavigate($oIETerran, GetReadHtml($race, $cRace)) ;v2
			makeBuildHtml($race, $cRace)
			_IENavigate($oIETerran, GetReadHtmlNew())
			FileDelete("copycurr.html")
		Case $selTabRace = 2
			$race = "Protoss"
			$cRace = GUICtrlRead($cProtoss)
			;GUICtrlSetData($lProtoss, GetReadFile($race, $cRace)) ;v1
			;_IENavigate($oIEProtoss, GetReadHtml($race, $cRace)) ;v2
			makeBuildHtml($race, $cRace)
			_IENavigate($oIEProtoss, GetReadHtmlNew())
			FileDelete("copycurr.html")
	EndSelect
	;MsgBox(0,"",GUICtrlRead($TabRaces) & " - " & $cRace & " - " & $cProtoss)
EndFunc


;-------------
;SHOW/HIDE GUI
;-------------
Global $isHide = False
Func showHide()
	If $isHide Then
		If $isOne Then
			GUISetState(@SW_SHOW,"Main")
		Else
			GUISetState(@SW_SHOW,"Counter")
		EndIf
		$isHide = False
	Else
		If $isOne Then
			GUISetState(@SW_HIDE,"Main")
		Else
			GUISetState(@SW_HIDE,"Counter")
		EndIf
		$isHide = True
	EndIf
EndFunc

Func buildActual()
	selectRace()
EndFunc

Func agrandarGUI()
	$height = $height + 25
	$width = $width + 7

	changeSize()
EndFunc

Func smallerGUI()
	$height = $height - 25
	$width = $width - 7

	changeSize()
EndFunc ;==> Set the GUI smaller.

Func changeSize()
	;Al cambiar tamaño que no se vaya todo a la mierda. Así no.
	;GUI
	WinMove($hGUI,"",10,10,$width,$height)
	;Tab
	GUICtrlSetPos($TabRaces,-1,-1,$width,$height)
	;Labels
	GUICtrlSetPos($lProtoss,5, 45, $width-10, $height-50)
	GUICtrlSetPos($lZerg,5, 45, $width-10, $height-50)
	GUICtrlSetPos($lTerran,5, 45, $width-10, $height-50)
	;Combos
	GUICtrlSetPos($cProtoss, 10, 20, 200, 100)
	GUICtrlSetPos($cZerg, 10, 20, 200, 100)
	GUICtrlSetPos($cTerran, 10, 20, 200, 100)
	;Botones
	GUICtrlSetPos($hHide_Button, $width-60, 0, 20, 20)
	GUICtrlSetPos($hMin_Button, $width-40, 0, 20, 20)
	GUICtrlSetPos($hExit_Button, $width-20, 0, 20, 20)
EndFunc ;==> Change the size of gui and the other interior components.

Func timerONOFF()
	If $isOK Then
		$isOK = False
		GUICtrlSetData($hTime_Button,"ON")
		GUICtrlSetBkColor($hTime_Button, 0xFFFFFF)
		ToolTip("")
	Else
		resetTimes()
		GUICtrlSetData($hTime_Button,"OFF")
		GUICtrlSetBkColor($hTime_Button, 0x555555)
		$isOK = True
	EndIf
EndFunc

Func guiCounterProtoss()
	makeCounterHtml("Protoss")
	_IENavigate($oIECounter, GetReadHtmlNew())
	FileDelete("copycurr.html")
EndFunc

Func guiCounterZerg()
	makeCounterHtml("Zerg")
	_IENavigate($oIECounter, GetReadHtmlNew())
	FileDelete("copycurr.html")
EndFunc

Func guiCounterTerran()
	makeCounterHtml("Terran")
	_IENavigate($oIECounter, GetReadHtmlNew())
	FileDelete("copycurr.html")
EndFunc

Func getHelp()
	makeHelpHtml()

	;Local $oIE = _IECreate("copycurr.html")
	;_IENavigate($oIE, GetReadHtmlNew(),1)
	_IENavigate($oIECounter, GetReadHtmlNew())
	changeGUI()
	FileDelete("copycurr.html")
EndFunc

HotKeySet("^>","showHide")
HotKeySet("^A","buildActual")
HotKeySet("^W","agrandarGUI")
HotKeySet("^Q","smallerGUI")
HotKeySet("^Z","timerONOFF")
HotKeySet("^+1","guiCounterTerran")
HotKeySet("^" & Chr(34),"guiCounterZerg")
HotKeySet("^·","guiCounterProtoss")
HotKeySet("^ª","changeGUI")


Func changeGUI()
	If $isOne Then
		GUISetState(@SW_HIDE, "Main")
		GUISetState(@SW_DISABLE, $hGUI)
		GUISetState(@SW_ENABLE, $hGUI2)
		GUISwitch($hGUI2)
		;GUIDelete($hGUI)
		GUISetState(@SW_SHOW, "Counter")
		$isOne = Not $isOne
	Else
		GUISetState(@SW_HIDE, "Counter")
		GUISetState(@SW_DISABLE, $hGUI2)
		GUISetState(@SW_ENABLE, $hGUI)
		GUISwitch($hGUI)
		GUISetState(@SW_SHOW, "Main")
		$isOne = Not $isOne
	EndIf
EndFunc

GUISetState(@SW_DISABLE, $hGUI2)
GUISetState(@SW_ENABLE, $hGUI)
GUISwitch($hGUI)
GUISetState(@SW_SHOW, "Main")

While 1
	;If ProcessExists($version) Then
	;	MsgBox(0, "Información", "El programa ya está corriendo.")
	;EndIf

    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE
            Exit
        Case $hHide_Button
			selectRace()
		Case $hMin_Button
			showHide()
        Case $hExit_Button
            Exit
		Case $hTime_Button
			timerONOFF()
		Case $hHelp_Button()
			getHelp()
		Case $hBack_Button
			changeGUI()
		Case $hTerran_Button()
			guiCounterTerran()
		Case $hZerg_Button()
			guiCounterZerg()
		Case $hProtoss_Button()
			guiCounterProtoss()
	EndSwitch
	timerSetOn($isOK)
	;Sleep(70)
WEnd