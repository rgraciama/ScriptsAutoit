Func makeHelpHtml()

	$content = "<html>" & @CRLF & _
"<head>" & @CRLF & _
	"<title>Help</title>"  & @CRLF & _
	"<script type=" & Chr(34) & "text/javascript" & Chr(34) & " src=" & Chr(34) & "http://code.jquery.com/jquery-1.9.1.js" & Chr(34) & "></script>"  & @CRLF & _
	"<script language=" & Chr(34) &"JavaScript"  & Chr(34) & " type="  & Chr(34) & _
			"text/javascript"  & Chr(34) & ">" & _
			"document.oncontextmenu = function(){return false} " & _
	"</script>" & @CRLF & _
	"<SCRIPT type=" & Chr(34) & "text/javascript" & Chr(34) & ">"  & @CRLF & _
		"$(document).ready(function () {"  & @CRLF & _
			"$instructions = $(" & Chr(34) & "<div class=\" & Chr(34) & "content\" & Chr(34) & ">\"  & @CRLF & _
						"<h2>Build Order</h2>\"  & @CRLF & _
						"<ol>\"  & @CRLF & _
							"<li>Select faction on the top sheets.</li>\"  & @CRLF & _
							"<li>Select build order on the selector box.</li>\"  & @CRLF & _
							"<li>Press green button or Ctrl+Shift+\" & Chr(34) & "a\" & Chr(34) & ".</li>\"  & @CRLF & _
						"</ol>\"  & @CRLF & _
						"<h2>Counter Units</h2>\"  & @CRLF & _
						"<ol>\"  & @CRLF & _
							"<li>Press Ctrl+Shift+\" & Chr(34) & "ª\" & Chr(34) & " to toggle the UI.</li>\"  & @CRLF & _
							"<li>Press Ctrl+Shift+{1,2,3} to upload counter units.\"  & @CRLF & _
							"<ul><li>1: Terran, 2: Zerg, 3: Protoss.</li></ul>\"  & @CRLF & _
						"</ol>\"  & @CRLF & _
						"<h2>Race Timer</h2>\"  & @CRLF & _
						"<ol>\"  & @CRLF & _
							"<li>Press ON/OFF button or Press Ctrl+Shift+\" & Chr(34) & "z\" & Chr(34) & ".</li>\"  & @CRLF & _
						"</ol>\"  & @CRLF & _
						"</div>" & Chr(34) & ");"  & @CRLF & _
			"$hotkeys = $(" & Chr(34) & "<div class=\" & Chr(34) & "content\" & Chr(34) & ">\"  & @CRLF & _
			"<h2>General</h2>\"  & @CRLF & _
			"<ul>\"  & @CRLF & _
				"<li>Ctrl+Shift+\" & Chr(34) & "a\" & Chr(34) & ": Download Build Order.</li>\"  & @CRLF & _
				"<li>Ctrl+Shift+\" & Chr(34) & "q\" & Chr(34) & ": Decrease UI size.</li>\"  & @CRLF & _
				"<li>Ctrl+Shift+\" & Chr(34) & "w\" & Chr(34) & ": Increase UI size.</li>\"  & @CRLF & _
			"</ul>\"  & @CRLF & _
			"<ul>\"  & @CRLF & _
				"<li>Ctrl+Shift+\" & Chr(34) & "<\" & Chr(34) & ": Hide/Show UI.</li>\"  & @CRLF & _
				"<li>Ctrl+Shift+\" & Chr(34) & "ª\" & Chr(34) & ": Toggle UI.</li>\"  & @CRLF & _
			"</ul>\"  & @CRLF & _
			"<h2>Build Order</h2>\"  & @CRLF & _
			"<ul>\"  & @CRLF & _
				"<li>Ctrl+Shift+\" & Chr(34) & "a\" & Chr(34) & ": Download Build Order.</li>\"  & @CRLF & _
				"<li>Ctrl+Shift+\" & Chr(34) & "q\" & Chr(34) & ": Decrease UI size.</li>\"  & @CRLF & _
				"<li>Ctrl+Shift+\" & Chr(34) & "w\" & Chr(34) & ": Increase UI size.</li>\"  & @CRLF & _
			"</ul>\"  & @CRLF & _
			"<h2>Counter Units</h2>\"   & @CRLF & _
			"<ul>\"   & @CRLF & _
				"<li>Ctrl+Shift+1: Terran Counters.</li>\"   & @CRLF & _
				"<li>Ctrl+Shift+2: Zerg Counters.</li>\"   & @CRLF & _
				"<li>Ctrl+Shift+3: Protoss Counters.</li>\"   & @CRLF & _
			"</ul>\"   & @CRLF & _
			"<h2>Race Timer</h2>\"   & @CRLF & _
			"<ul>\"   & @CRLF & _
				"<li>Ctrl+Shift+\" & Chr(34) & "z\" & Chr(34) & ": Toggle Timer.</li>\"   & @CRLF & _
			"</ul>\"   & @CRLF & _
			"</div>" & Chr(34) & ");"   & @CRLF & _
		"$agraiments = $(" & Chr(34) & "<div class=\" & Chr(34) & "content\" & Chr(34) & ">\"   & @CRLF & _
			"<h2>History</h2>\"   & @CRLF & _
			"<p>This tool appears at the moment that I\" & Chr(33) & "m released that It\" & Chr(33) & "s important \"   & @CRLF & _
			"to improve sc skills having in count the Build orders, counter units, timers...</p>\"   & @CRLF & _
			"<p>Meanwhile I was thinking on it I take the decision to start to do the tool. \"   & @CRLF & _
			"The beginning It was difficult, but step by step the tool gets better and It takes me a good improvement. \"   & @CRLF & _
			"You can follow me at \" & @CRLF & _
			"<a href=\" & Chr(34) & "http://www.ggtracker.com/players/725853/Rulo\" & Chr(34) & " target=\" & Chr(34) & "_blank\" & Chr(34) & ">Rulo GGtracker</a>.</p> \"   & @CRLF & _
			"<p>If you want contact me for anything, here my mail <a href=\" & Chr(34) & "mailto:r.gracia.maiques@gmail.com\" & Chr(34) & ">r.gracia.maiques@gmail.com</a></p>\"   & @CRLF & _
			"<h2>Agraiments</h2>\"   & @CRLF & _
			"<p>To my friends Harlekin and Limguear, they try the tool since it started and used it \"   & @CRLF & _
			"to improve their sc skills and help me to improve the tool. You can follow them at \" & @CRLF & _
			"<a href=\" & Chr(34) & "http://www.ggtracker.com/players/579630/Harlekin\" & Chr(34) & " target=\" & Chr(34) & "_blank\" & Chr(34) & ">Harlekin GGtracker</a> \"   & @CRLF & _
			"and <a href=\" & Chr(34) & "http://www.ggtracker.com/players/1298379/Limguear\" & Chr(34) & " target=\" & Chr(34) & "_blank\" & Chr(34) & ">Limguear GGtracker</a>. \"   & @CRLF & _
			"<p>Thank you for use it and GG!</p> \"   & @CRLF & _
			"</div>" & Chr(34) & ");"   & @CRLF & _
			"$(" & Chr(34) & ".button" & Chr(34) & ").mouseover(function () {"   & @CRLF & _
			"$(this).css(" & Chr(34) & "background-color" & Chr(34) & "," & Chr(34) & "red" & Chr(34) & ");"  & @CRLF & _
			"$(" & Chr(34) & ".frame" & Chr(34) & ").css(" & Chr(34) & "border-color" & Chr(34) & "," & Chr(34) & "red" & Chr(34) & ");"  & @CRLF & _
			"});"  & @CRLF & _
			"$(" & Chr(34) & ".button" & Chr(34) & ").mouseleave(function () {"  & @CRLF & _
			"$(" & Chr(34) & ".frame" & Chr(34) & ").fadeTo(" & Chr(34) & "fast" & Chr(34) & ",1);"  & @CRLF & _
			"$(this).css(" & Chr(34) & "background-color" & Chr(34) & "," & Chr(34) & "blue" & Chr(34) & ");"  & @CRLF & _
			"$(" & Chr(34) & ".frame" & Chr(34) & ").css(" & Chr(34) & "border-color" & Chr(34) & "," & Chr(34) & "blue" & Chr(34) & ");"  & @CRLF & _
			"});"  & @CRLF & _
			"$(" & Chr(34) & ".button" & Chr(34) & ").click(function () {"  & @CRLF & _
			"$(" & Chr(34) & ".button" & Chr(34) & ").fadeTo(" & Chr(34) & "fast" & Chr(34) & ",0.25);"  & @CRLF & _
			"$(this).fadeTo(" & Chr(34) & "fast" & Chr(34) & ",1);"  & @CRLF & _
			"});"  & @CRLF & _
			"$(" & Chr(34) & "#b1" & Chr(34) & ").click(function () {"  & @CRLF & _
			"$(" & Chr(34) & ".content" & Chr(34) & ").remove();"  & @CRLF & _
			"$(" & Chr(34) & ".frame" & Chr(34) & ").append($instructions);"  & @CRLF & _
			"});"  & @CRLF & _
			"$(" & Chr(34) & "#b2" & Chr(34) & ").click(function () {"  & @CRLF & _
			"$(" & Chr(34) & ".content" & Chr(34) & ").remove();"  & @CRLF & _
			"$(" & Chr(34) & ".frame" & Chr(34) & ").append($hotkeys);"  & @CRLF & _
			"});"  & @CRLF & _
			"$(" & Chr(34) & "#b3" & Chr(34) & ").click(function () {"  & @CRLF & _
			"$(" & Chr(34) & ".content" & Chr(34) & ").remove();"  & @CRLF & _
			"$(" & Chr(34) & "p" & Chr(34) & ").remove();"  & @CRLF & _
			"$(" & Chr(34) & ".frame" & Chr(34) & ").append($agraiments);"  & @CRLF & _
			"});"  & @CRLF & _
			"});"  & @CRLF & _
			"</SCRIPT>"
	$content = $content  & @CRLF & _
		"<STYLE type=" & Chr(34) & "text/css" & Chr(34) & ">"  & @CRLF & _
		".button {" & @CRLF & _
		"height: 22px;"  & @CRLF & _
		"width: 90px;"  & @CRLF & _
		"display: inline-block;"  & @CRLF & _
		"background-color: #0000FF;"  & @CRLF & _
		"border-top-left-radius:5px;"  & @CRLF & _
		"border-top-right-radius:5px;"  & @CRLF & _
		"color: #FFFFFF;"  & @CRLF & _
		"font-family: Calibri;"  & @CRLF & _
		"text-align:center;"  & @CRLF & _
		"font-weight: bold;"  & @CRLF & _
		"}"  & @CRLF & _
		".frame {"  & @CRLF & _
		"width: 700px;"  & @CRLF & _
		"/*height: 300px;*/"  & @CRLF & _
		"border:5px solid blue;"  & @CRLF & _
		"border-bottom-right-radius:5px;"  & @CRLF & _
		"border-bottom-left-radius:5px;"  & @CRLF & _
		"border-color: #0000FF;"  & @CRLF & _
		"}"  & @CRLF & _
		".content {"  & @CRLF & _
		"color: #0000FF;"  & @CRLF & _
		"font-family: Calibri;"  & @CRLF & _
		"}"  & @CRLF & _
		"</STYLE>"
	$content = $content  & @CRLF & _
		"</head>"  & @CRLF & _
		"<body>"  & @CRLF & _
		"<div class=" & Chr(34) & "button" & Chr(34) & " id=" & Chr(34) & "b1" & Chr(34) & ">Intructions</div>" & @CRLF & _
		"<div class=" & Chr(34) & "button" & Chr(34) & " id=" & Chr(34) & "b2" & Chr(34) & ">Hotkeys</div>" & @CRLF & _
		"<div class=" & Chr(34) & "button" & Chr(34) & " id=" & Chr(34) & "b3" & Chr(34) & ">Agraiments</div>" & @CRLF & _
		"<div class=" & Chr(34) & "frame" & Chr(34) & ">"  & @CRLF & _
		"<div class=" & Chr(34) & "content" & Chr(34) & ">"  & @CRLF & _
		"<h2>Select One Sheet</h2>"  & @CRLF & _
		"</div>"  & @CRLF & _
		"</div>"  & @CRLF & _
		"</body>"  & @CRLF & _
		"</html>"
	DoCopyTemplate($content)
	return $content

EndFunc ;==> Crea un fichero Html.