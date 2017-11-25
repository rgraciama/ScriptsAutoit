#include <File.au3>
#include <Array.au3>

Func arrayFilesToString($race)
	Local $FileList = _FileListToArray(@ScriptDir & "\" & $race)
	If @error = 1 Then
		MsgBox(0, "", "No Folders Found.")
		Exit
	EndIf
	If @error = 4 Then
		MsgBox(0, "", "No Files Found.")
		Exit
	EndIf
	;_ArrayDisplay($FileList, "$FileList")
	return _ArrayToString($FileList, "|", 2)


EndFunc

Func firstFileToString($race)
	Local $FileList = _FileListToArray(@ScriptDir & "\" & $race)

	If @error = 1 Then
		MsgBox(0, "", "No Folders Found.")
		Exit
	EndIf
	If @error = 4 Then
		MsgBox(0, "", "No Files Found.")
		Exit
	EndIf
	;_ArrayDisplay($FileList, "$FileList")
	return _ArrayToString($FileList, -1, 1,1)

EndFunc