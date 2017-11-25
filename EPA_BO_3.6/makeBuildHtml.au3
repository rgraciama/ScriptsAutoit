;--------------
;READ TXT (PARA LEER TXT) AHORA YA NO SE USA V1:
;--------------
Func GetReadFile(ByRef $race, ByRef $cRace)
	$file = FileOpen($race & "\" & $cRace, 0)

	; Cheque si el fichero abierto es leído correctamente
	If $file = -1 Then
		MsgBox(0, "Error", "Incapaz de abrir el fichero.")
		Exit
	EndIf
	; lee un  1 por tiempo hasta que  EOF (final del fichero) es alcanzado
	$fileContent = FileRead($file)
	;MsgBox(0,"",$fileContent)
	FileClose($file)

	return $fileContent
EndFunc
;--------------
;READ HTML (PARA LEER HTML) AHORA YA NO SE USA V2:
;--------------
Func GetReadHtml(ByRef $race, ByRef $cRace)
	$text = StringReplace(@ScriptDir, "\", "/")
	$res = "file:///" & $text & "/" & $race & "/" & $cRace
	;MsgBox(0,"",$res)
	return $res
EndFunc

Func GetReadHtmlNew()
	$text = StringReplace(@ScriptDir, "\", "/")
	$res = "file:///" & $text & "/copycurr.html"

	return $res
EndFunc

Func makeBuildHtml($race,$cRace)
	;CSS añadido y script para boton derecho
	$content = "<!DOCTYPE html><html><head>" & _
			"<style type="& Chr(34) & "text/css" & Chr(34) & ">" & _
			"body {" & _
			"    margin:0px;" & _
			"    background-color: transparent;" & _
			"}" & _
			"table {" & _
			"	font-family: Calibri;" & _
			"	font-weight: 20px;" & _
			"	font-weight: bold;" & _
			"}" & _
			"th {" & _
			"	font-weight: underline;" & _
			"}" & _
			"td {" & _
			"	vertical-align:middle;" & _
			"}" & _
			"img {" & _
			"	padding-right: 5px;" & _
			"}" & _
			".submin {" & _
			"	color: blue;" & _
			"}" & _
			".item {" & _
			"	color: green;" & _
			"}" & _
			".time {" & _
			"	color: red;" & _
			"}" & _
			".done {" & _
			"	color: orange;" & _
			"}" & _
			"</style>" & _
			"</head>" & _
			"<body><script language=" & Chr(34) &"JavaScript"  & Chr(34) & " type="  & Chr(34) & _
			"text/javascript"  & Chr(34) & ">" & _
			"document.oncontextmenu = function(){return false} " & _
			"</script><div><table class=" & Chr(34) & "build-order" & Chr(34) & ">"
	;PARTE PRIMERA HTML
	$file = FileOpen($race & "\" & $cRace, 0)

	; Chequea si el fichero abierto es leído correctamente
	If $file = -1 Then
		MsgBox(0, "Error", "Incapaz de abrir el fichero.")
		Exit
	EndIf
	; Lee las líneas de texto mientras no es encontrado EOF (final del fichero)
	While 1
		;CADA LINEA
		$line = FileReadLine($file)
		;MsgBox(0,"",$line)
		If @error = -1 Then ExitLoop

		$content = $content & "<tr>"
		$tokens = ""
		$tokens = StringSplit ($line, ";")

		For $i=1 To $tokens[0]
			$content = $content & GetReplaceLine($tokens[$i])
		Next
		$content = $content & "</tr>"
	Wend
	$content = $content & "</table></div></body></html>"

	FileClose($file)
	;MsgBox(0,"",$content)
	DoCopyTemplate($content) ;V3.1
	return $content

EndFunc ;==> Crea un fichero Html. Básandose en una build en txt.

Func GetReplaceLine(ByRef $split)
	;MODIFICA LAS CELDAS POR FILA
	$conSplit = "<td "
	$char = ""

	$len = StringLen($split)
	For $j = 1 To $len
		$char = StringMid($split, $j, 1)
		Select
			Case $char = "$"
				$conSplit =  $conSplit & "class="  & Chr(34) & "submin" & Chr(34) & ">" & _
							"<img src="  & Chr(34) & "pics\submin.png"  & Chr(34) & ">"
			Case $char = "*"
				$conSplit =  $conSplit & "class="  & Chr(34) & "item" & Chr(34) & ">" & _
							"<img src="  & Chr(34) & "pics\item.png"  & Chr(34) & ">"
			Case $char = "#"
				$conSplit =  $conSplit & "class="  & Chr(34) & "time" & Chr(34) & ">" & _
							"<img src="  & Chr(34) & "pics\time.png"  & Chr(34) & ">"
			Case $char = "!"
				$conSplit =  $conSplit & "class="  & Chr(34) & "desc" & Chr(34) & ">" & _
							"<img src="  & Chr(34) & "pics\desc.png"  & Chr(34) & ">"
			Case $char = "@"
				$conSplit =  $conSplit & "class="  & Chr(34) & "mine" & Chr(34) & ">" & _
							"<img src="  & Chr(34) & "pics\mine.gif"  & Chr(34) & ">"
			Case $char = "^"
				$conSplit =  $conSplit & "class="  & Chr(34) & "gas" & Chr(34) & ">" & _
							"<img src="  & Chr(34) & "pics\gas.gif"  & Chr(34) & ">"
			Case $char = "%"
				$conSplit =  $conSplit & "class="  & Chr(34) & "done" & Chr(34) & ">" & _
							"<img src="  & Chr(34) & "pics\done.png"  & Chr(34) & ">"
			Case Else
				If $conSplit = "<td " Then
					$conSplit =  $conSplit & ">" & $char
				Else
					$conSplit =  $conSplit & $char
				EndIf
		EndSelect
	Next
	$conSplit =  $conSplit & "</td>"

	;MsgBox(0,"",$conSplit)

	return $conSplit

EndFunc

;YA NO SE USA
Func DoCopyTemplate(ByRef $data)
	If FileExists ("copycurr.html") Then
		FileDelete("copycurr.html")
	EndIf
	;En la version v3.1, copiaba un fichero ahora lo crea.
	FileCopy ("", "copycurr.html")

	FileWrite ( "copycurr.html",$data)
EndFunc