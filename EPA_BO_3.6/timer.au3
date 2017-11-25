Global $hab = 30 ;Hability of faction
Global $worker = 13 ;SCV, probe, drone
Global $creep = 15 ;Creep Expand

Global $countHab = 0 ;counter of Hability
Global $countWork = 0 ;counter of worker
Global $countCreep = 0

Global $begWork = TimerInit() ;start time worker
Global $begHab = TimerInit() ;start time hab
Global $begCreep = TimerInit() ;start time hab

Func resetTimes()
	Global $hab = 36 ;Hability of faction
	Global $worker = 20 ;SCV, probe, drone
	Global $creep = 15 ;Creep Expand

	Global $countHab = 0 ;counter of Hability
	Global $countWork = 0 ;counter of worker
	Global $countCreep = 0

	Global $begWork = TimerInit() ;start time worker
	Global $begHab = TimerInit() ;start time hab
	Global $begCreep = TimerInit() ;start time hab
EndFunc

Func timerSetOn($isRun)

	If $isRun = True Then
		$difWork = TimerDiff($begWork)
		$difWorkL = StringLeft($difWork, StringInStr($difWork, ".") -1)

		$difHab = TimerDiff($begHab)
		$difHabL = StringLeft($difHab, StringInStr($difHab, ".") -1)

		$difCreep = TimerDiff($begCreep)
		$difCreepL = StringLeft($difCreep, StringInStr($difCreep, ".") -1)

		$countWork = int($difWorkL/1000)
		$countHab = int($difHabL/1000)
		$countCreep = int($difCreepL/1000)

		ToolTip( "Hability: " & ($hab - $countHab) & @CRLF & _
				 "Worker: " & ($worker - $countWork) & @CRLF & _
				 "Creep  : " & ($creep - $countCreep), @DesktopWidth-90,20,"", 0)
		;Sleep(200)
		If (int($countWork) >= $worker) Then
			$begWork = TimerInit()
			;Reproducir sonido
			SoundPlay("")
			SoundPlay(@ScriptDir & "\sounds\worker.wav", 1)
		EndIf
		If (int($countHab) >= $hab) Then
			$begHab = TimerInit()
			;Reproducir sonido
			SoundPlay("")
			SoundPlay(@ScriptDir & "\sounds\hab.wav",1)
		EndIf
		If (int($countCreep) >= $Creep) Then
			$begCreep = TimerInit()
			;Reproducir sonido
			SoundPlay("")
			SoundPlay(@ScriptDir & "\sounds\creep.wav",1)
		EndIf
	EndIf
EndFunc