;#include <makeBuildHtml.au3>

Func makeCounterHtml($race)

	;head
	$head = getHeadCounter()
	;body
	$body = getBodyCounter($race)

	$content = $head & $body
	DoCopyTemplate($content)
	return $content

EndFunc ;==> Crea un fichero Html.

Func getHeadCounter()
	;head, body = content
	$head = "<html>" & _
	"<head>" & _
"<style type=" & Chr(34) & "text/css" & Chr(34) & ">" & _
".strong {" & _
	"border-top: 1px solid green;" & _
	"border-left: 1px solid green;" & _
	"border-right: 1px solid green;" & _
	"border-bottom: 5px solid green;" & _
"}" & _
".weak {" & _
	"border-top: 5px solid red;" & _
	"border-left: 1px solid red;" & _
	"border-right: 1px solid red;" & _
	"border-bottom: 1px solid red;" & _
"}" & _
".rowy {" & _
	"border-bottom: 1px dashed black;" & _
	"background-color: grey;" & _
"}" & _
".none {" & _
	"font-weight:bold;" & _
	"font-family: 'Calibri';" & _
	"font-size: x-large;" & _
	"margin: 0 17px 0 17px;" & _
"}" & _
"/* URL : url('http://eu.battle.net/sc2/static/images/game/unit-thumbs-54x49-table.gif' */" & _
"/**** Units Thumbnails styles : 54x49	Added code to fix IE6 bug. Don't remove it! ****/" & _
".unit-thumb-54x49, .unit-thumb-54x49 span {display:block; width:54px;}" & _
".unit-thumb-54x49 span {height:49px; background:url('pics/unit-thumbs-54x49-table.gif') no-repeat;}" & _
"/* Protoss */" & _
".unit-thumb-54x49 .probe {background-position:0 -12px;}" & _
".unit-thumb-54x49 .zealot {background-position:-54px -12px;}" & _
".unit-thumb-54x49 .stalker {background-position:-108px -12px;}" & _
".unit-thumb-54x49 .sentry {background-position:-162px -12px;}" & _
".unit-thumb-54x49 .observer {background-position:-216px -12px;}" & _
".unit-thumb-54x49 .immortal {background-position:0 -70px;}" & _
".unit-thumb-54x49 .warp-prism {background-position:-54px -70px;}" & _
".unit-thumb-54x49 .colossus {background-position:-108px -70px;}" & _
".unit-thumb-54x49 .phoenix {background-position:-162px -71px;}" & _
".unit-thumb-54x49 .void-ray {background-position:-216px -71px;}" & _
".unit-thumb-54x49 .high-templar {background-position:0 -131px;}" & _
".unit-thumb-54x49 .dark-templar {background-position:-54px -131px;}" & _
".unit-thumb-54x49 .archon {background-position:-108px -131px;}" & _
".unit-thumb-54x49 .carrier {background-position:-162px -131px;}" & _
".unit-thumb-54x49 .mothership {background-position:-216px -131px;}" & _
".unit-thumb-54x49 .mothership-core {background-position: -54px -597px;}" & _
".unit-thumb-54x49 .oracle {background-position: 2px -597px;}" & _
".unit-thumb-54x49 .tempest {background-position: -108px -597px;}" & _
"/* Terran */" & _
".unit-thumb-54x49 .scv {background-position:0 -209px;}" & _
".unit-thumb-54x49 .marine {background-position:-54px -209px;}" & _
".unit-thumb-54x49 .marauder {background-position:-108px -209px;}" & _
".unit-thumb-54x49 .reaper{background-position:-162px -209px;}" & _
".unit-thumb-54x49 .ghost {background-position:-216px -209px;}" & _
".unit-thumb-54x49 .hellion {background-position:0 -268px;}" & _
".unit-thumb-54x49 .siege-tank {background-position:-54px -268px;}" & _
".unit-thumb-54x49 .thor {background-position:-108px -268px;}" & _
".unit-thumb-54x49 .viking {background-position:-162px -268px;}" & _
".unit-thumb-54x49 .viking-assault {background:url('pics/unit-thumbs-sample.gif') no-repeat; background-position:0 0;}" & _
".unit-thumb-54x49 .medivac {background-position:-216px -268px;}" & _
".unit-thumb-54x49 .raven {background-position:0 -327px;}" & _
".unit-thumb-54x49 .banshee {background-position:-53px -326px;}" & _
".unit-thumb-54x49 .battlecruiser {background-position:-108px -326px;}" & _
".unit-thumb-54x49 .hellbat {background-position: -54px -656px;}" & _
".unit-thumb-54x49 .widow-mine {background-position: 0 -654px;}" & _
"/* Zerg */" & _
".unit-thumb-54x49 .larva {background-position:0 -402px;}" & _
".unit-thumb-54x49 .drone {background-position:-54px -402px;}" & _
".unit-thumb-54x49 .overlord {background-position:-108px -402px;}" & _
".unit-thumb-54x49 .zergling{background-position:-162px -402px;}" & _
".unit-thumb-54x49 .queen {background-position:-216px -402px;}" & _
".unit-thumb-54x49 .hydralisk {background-position:0 -460px;}" & _
".unit-thumb-54x49 .baneling {background-position:-54px -460px;}" & _
".unit-thumb-54x49 .overseer {background-position:-108px -464px;}" & _
".unit-thumb-54x49 .roach {background-position:-162px -460px;}" & _
".unit-thumb-54x49 .infestor {background-position:-216px -460px;}" & _
".unit-thumb-54x49 .mutalisk {background-position:0 -518px;}" & _
".unit-thumb-54x49 .corruptor {background-position:-54px -518px;}" & _
".unit-thumb-54x49 .nydus-worm {background-position:-108px -518px;}" & _
".unit-thumb-54x49 .ultralisk {background-position:-162px -522px;}" & _
".unit-thumb-54x49 .brood-lord {background-position:-216px -518px;}" & _
".unit-thumb-54x49 .swarm-host {background-position: -57px -708px;}" & _
".unit-thumb-54x49 .viper {background-position: -2px -715px;}" & _
"</style>" & _
"<script language=" & Chr(34) &"JavaScript"  & Chr(34) & " type="  & Chr(34) & _
"text/javascript"  & Chr(34) & ">" & _
"document.oncontextmenu = function(){return false} " & _
"</script>" & _
"</head>"

	return $head
EndFunc

Func getBodyCounter($race)
	$body = ""
	Select
		Case $race = "Terran"
			$body = "<body>" & _
	"<hr></hr>" & _
	"<table>" & _
		"<tr>" & _
		"<td rowspan=" & Chr(34) & "2" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "scv" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "none" & Chr(34) & ">X</span></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "none" & Chr(34) & ">X</span></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "none" & Chr(34) & ">X</span></td>" & _
		"<td rowspan=" & Chr(34) & "2" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "marine" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "marauder" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "hydralisk" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "immortal" & Chr(34) & "></td>" & _
		"<td rowspan=" & Chr(34) & "2" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "marauder" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "thor" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "roach" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "stalker" & Chr(34) & "></td>" & _
		"</tr>" & _
		"<tr>" & _
		"<!--1-->" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "reaper" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "baneling" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "oracle" & Chr(34) & "></td>" & _
		"<!--2-->" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "siege-tank" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "baneling" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "colossus" & Chr(34) & "></td>" & _
		"<!--3-->" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "marine" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "zergling" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "zealot" & Chr(34) & "></td>" & _
		"</tr>" & _
	"</table>"
	$body = $body & _
		"<hr></hr>" & _
		"<table>" & _
		"<tr>" & _
		"<td rowspan=" & Chr(34) & "2" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "reaper" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "scv" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "drone" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "probe" & Chr(34) & "></td>" & _
		"<td rowspan=" & Chr(34) & "2" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "ghost" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "raven" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "infestor" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "high-templar" & Chr(34) & "></td>" & _
		"<td rowspan=" & Chr(34) & "2" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "hellion" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "none" & Chr(34) & ">X</span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "zergling" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "zealot" & Chr(34) & "></td>" & _
		"</tr>" & _
		"<tr>" & _
		"<!--1-->" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "marauder" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "roach" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "stalker" & Chr(34) & "></td>" & _
		"<!--2-->" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "marauder" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "zergling" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "stalker" & Chr(34) & "></td>" & _
		"<!--3-->" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "marauder" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "roach" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "stalker" & Chr(34) & "></td>" & _
		"</tr>" & _
		"</table>"
		$body = $body & _
		"<hr></hr>" & _
		"<table>" & _
		"<tr>" & _
		"<td rowspan=" & Chr(34) & "2" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "siege-tank" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "marine" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "none" & Chr(34) & ">X</span></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "none" & Chr(34) & ">X</span></td>" & _
		"<td rowspan=" & Chr(34) & "2" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "thor" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "marine" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "mutalisk" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "stalker" & Chr(34) & "></td>" & _
		"<td rowspan=" & Chr(34) & "2" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "medivac" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "none" & Chr(34) & ">X</span></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "none" & Chr(34) & ">X</span></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "none" & Chr(34) & ">X</span></td>" & _
		"</tr>" & _
		"<tr>" & _
		"<!--1-->" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "marauder" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "roach" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "stalker" & Chr(34) & "></td>" & _
		"<!--2-->" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "marauder" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "zergling" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "immortal" & Chr(34) & "></td>" & _
		"<!--3-->" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "none" & Chr(34) & ">X</span></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "none" & Chr(34) & ">X</span></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "none" & Chr(34) & ">X</span></td>" & _
		"</tr>" & _
	"</table>"
	$body = $body & _
	"<hr></hr>" & _
	"<table>" & _
		"<tr>" & _
		"<td rowspan=" & Chr(34) & "2" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "raven" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "banshee" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "roach" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "dark-templar" & Chr(34) & "></td>" & _
		"<td rowspan=" & Chr(34) & "2" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "banshee" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "siege-tank" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "ultralisk" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "colossus" & Chr(34) & "></td>" & _
		"<td rowspan=" & Chr(34) & "2" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "viking" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "battlecruiser" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "corruptor" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "void-ray" & Chr(34) & "></td>" & _
		"</tr>" & _
		"<tr>" & _
		"<!--1-->" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "ghost" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "corruptor" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "phoenix" & Chr(34) & "></td>" & _
		"<!--2-->" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "viking" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "hydralisk" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "phoenix" & Chr(34) & "></td>" & _
		"<!--3-->" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "marine" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "mutalisk" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "stalker" & Chr(34) & "></td>" & _
		"</tr>" & _
		"</tr>" & _
		"</table>"
		$body = $body & _
		"<hr></hr>" & _
		"<table>" & _
		"<tr>" & _
		"<td rowspan=" & Chr(34) & "2" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "battlecruiser" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "thor" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "mutalisk" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "carrier" & Chr(34) & "></td>" & _
		"<td rowspan=" & Chr(34) & "2" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "hellbat" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "none" & Chr(34) & ">X</span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "zergling" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "zealot" & Chr(34) & "></td>" & _
		"<td rowspan=" & Chr(34) & "2" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "widow-mine" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "marauder" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "roach" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "immortal" & Chr(34) & "></td>" & _
		"</tr>" & _
		"<tr>" & _
		"<!--1-->" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "viking" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "corruptor" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "void-ray" & Chr(34) & "></td>" & _
		"<!--2-->" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "marauder" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "baneling" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "stalker" & Chr(34) & "></td>" & _
		"<!--3-->" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "raven" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "overseer" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "observer" & Chr(34) & "></td>" & _
		"</tr>" & _
		"</tr>" & _
	"</table>" & _
	"<hr></hr>" & _
"</body>" & _
"</html>"
		Case $race = "Zerg"
			$body = "<body>" & _
	"<hr></hr>" & _
	"<table>" & _
		"<tr>" & _
		"<td rowspan=" & Chr(34) & "2" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "drone" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "none" & Chr(34) & ">X</span></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "none" & Chr(34) & ">X</span></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "none" & Chr(34) & ">X</span></td>" & _
		"<td rowspan=" & Chr(34) & "2" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "zergling" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "marauder" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "hydralisk" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "stalker" & Chr(34) & "></td>" & _
		"<td rowspan=" & Chr(34) & "2" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "queen" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "hellion" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "mutalisk" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "void-ray" & Chr(34) & "></td>" & _
		"</tr>" & _
		"<tr>" & _
		"<!--1-->" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "reaper" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "baneling" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "oracle" & Chr(34) & "></td>" & _
		"<!--2-->" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "hellion" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "baneling" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "colossus" & Chr(34) & "></td>" & _
		"<!--3-->" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "marine" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "zergling" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "zealot" & Chr(34) & "></td>" & _
		"</tr>" & _
	"</table>"
	$body = $body & _
		"<hr></hr>" & _
		"<table>" & _
		"<tr>" & _
		"<td rowspan=" & Chr(34) & "2" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "hydralisk" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "banshee" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "mutalisk" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "void-ray" & Chr(34) & "></td>" & _
		"<td rowspan=" & Chr(34) & "2" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "baneling" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "marine" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "zergling" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "zealot" & Chr(34) & "></td>" & _
		"<td rowspan=" & Chr(34) & "2" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "roach" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "hellion" & Chr(34) & "></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "zergling" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "zealot" & Chr(34) & "></td>" & _
		"</tr>" & _
		"<tr>" & _
		"<!--1-->" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "siege-tank" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "zergling" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "colossus" & Chr(34) & "></td>" & _
		"<!--2-->" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "marauder" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "roach" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "stalker" & Chr(34) & "></td>" & _
		"<!--3-->" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "marauder" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "ultralisk" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "immortal" & Chr(34) & "></td>" & _
		"</tr>" & _
		"</table>"
		$body = $body & _
		"<hr></hr>" & _
		"<table>" & _
		"<tr>" & _
		"<td rowspan=" & Chr(34) & "2" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "infestor" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "marine" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "mutalisk" & Chr(34) & "></span></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "immortal" & Chr(34) & "></span></td>" & _
		"<td rowspan=" & Chr(34) & "2" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "mutalisk" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "viking" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "brood-lord" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "void-ray" & Chr(34) & "></td>" & _
		"<td rowspan=" & Chr(34) & "2" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "corruptor" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "battlecruiser" & Chr(34) & "></span></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "mutalisk" & Chr(34) & "></span></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "phoenix" & Chr(34) & "></span></td>" & _
		"</tr>" & _
		"<tr>" & _
		"<!--1-->" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "ghost" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "ultralisk" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "high-templar" & Chr(34) & "></td>" & _
		"<!--2-->" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "thor" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "corruptor" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "phoenix" & Chr(34) & "></td>" & _
		"<!--3-->" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "viking" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "hydralisk" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "void-ray" & Chr(34) & "></td>" & _
		"</tr>" & _
	"</table>"
	$body = $body & _
	"<hr></hr>" & _
	"<table>" & _
		"<tr>" & _
		"<td rowspan=" & Chr(34) & "2" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "ultralisk" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "marauder" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "roach" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "stalker" & Chr(34) & "></td>" & _
		"<td rowspan=" & Chr(34) & "2" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "brood-lord" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "marine" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "hydralisk" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "stalker" & Chr(34) & "></td>" & _
		"<td rowspan=" & Chr(34) & "2" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "swarm-host" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "marine" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "stalker" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "roach" & Chr(34) & "></td>" & _
		"</tr>" & _
		"<tr>" & _
		"<!--1-->" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "banshee" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "mutalisk" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "void-ray" & Chr(34) & "></td>" & _
		"<!--2-->" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "viking" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "corruptor" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "void-ray" & Chr(34) & "></td>" & _
		"<!--3-->" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "baneling" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "hellion" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "archon" & Chr(34) & "></td>" & _
		"</tr>" & _
		"</tr>" & _
		"</table>" & _
		"<hr></hr>"
		$body = $body & _
		"<table>" & _
		"<tr>" & _
		"<td rowspan=" & Chr(34) & "2" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "viper" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "siege-tank" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "colossus" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "hydralisk" & Chr(34) & "></td>" & _
		"<td rowspan=" & Chr(34) & "2" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "overlord" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "none" & Chr(34) & ">X</span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "none" & Chr(34) & ">X</span></span></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "none" & Chr(34) & ">X</span></span></td>" & _
		"<td rowspan=" & Chr(34) & "2" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "overseer" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "banshee" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "roach" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "dark-templar" & Chr(34) & "></td>" & _
		"</tr>" & _
		"<tr>" & _
		"<!--1-->" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "viking" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "mutalisk" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "phoenix" & Chr(34) & "></td>" & _
		"<!--2-->" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "none" & Chr(34) & ">X</span></span></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "none" & Chr(34) & ">X</span></span></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "none" & Chr(34) & ">X</span></span></td>" & _
		"<!--3-->" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "viking" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "mutalisk" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "stalker" & Chr(34) & "></td>" & _
		"</tr>" & _
		"</tr>" & _
	"</table>" & _
	"<hr></hr>" & _
"</body>" & _
"</html>"
		Case $race = "Protoss"
			$body = "<body>" & _
	"<hr></hr>" & _
	"<table>" & _
		"<tr>" & _
		"<td rowspan=" & Chr(34) & "2" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "probe" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "none" & Chr(34) & ">X</span></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "none" & Chr(34) & ">X</span></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "none" & Chr(34) & ">X</span></td>" & _
		"<td rowspan=" & Chr(34) & "2" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "zealot" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "marauder" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "zergling" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "immortal" & Chr(34) & "></td>" & _
		"<td rowspan=" & Chr(34) & "2" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "stalker" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "reaper" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "mutalisk" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "void-ray" & Chr(34) & "></td>" & _
		"</tr>" & _
		"<tr>" & _
		"<!--3-->" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "reaper" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "baneling" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "oracle" & Chr(34) & "></td>" & _
		"<!--1-->" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "hellion" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "roach" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "colossus" & Chr(34) & "></td>" & _
		"<!--2-->" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "marauder" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "zergling" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "immortal" & Chr(34) & "></td>" & _
		"</tr>" & _
	"</table>"
	$body = $body & _
		"<hr></hr>" & _
		"<table>" & _
		"<tr>" & _
		"<td rowspan=" & Chr(34) & "2" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "sentry" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "none" & Chr(34) & ">X</span></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "zergling" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "zealot" & Chr(34) & "></td>" & _
		"<td rowspan=" & Chr(34) & "2" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "immortal" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "siege-tank" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "roach" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "stalker" & Chr(34) & "></td>" & _
		"<td rowspan=" & Chr(34) & "2" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "colossus" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "marine" & Chr(34) & ">" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "zergling" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "zealot" & Chr(34) & "></td>" & _
		"</tr>" & _
		"<tr>" & _
		"<!--1-->" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "reaper" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "hydralisk" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "stalker" & Chr(34) & "></td>" & _
		"<!--2-->" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "marine" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "zergling" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "zealot" & Chr(34) & "></td>" & _
		"<!--3-->" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "viking" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "corruptor" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "immortal" & Chr(34) & "></td>" & _
		"</tr>" & _
		"</table>"
		$body = $body & _
		"<hr></hr>" & _
		"<table>" & _
		"<tr>" & _
		"<td rowspan=" & Chr(34) & "2" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "phoenix" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "banshee" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "mutalisk" & Chr(34) & "></span></span></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "void-ray" & Chr(34) & "></span></span></td>" & _
		"<td rowspan=" & Chr(34) & "2" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "void-ray" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "battlecruiser" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "corruptor" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "carrier" & Chr(34) & "></td>" & _
		"<td rowspan=" & Chr(34) & "2" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "mothership" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "none" & Chr(34) & ">X</span></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "none" & Chr(34) & ">X</span></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "none" & Chr(34) & ">X</span></td>" & _
		"</tr>" & _
		"<tr>" & _
		"<!--1-->" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "battlecruiser" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "corruptor" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "carrier" & Chr(34) & "></td>" & _
		"<!--2-->"  & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "viking" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "mutalisk" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "phoenix" & Chr(34) & "></td>" & _
		"<!--3-->" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "viking" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "corruptor" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "void-ray" & Chr(34) & "></td>" & _
		"</tr>" & _
	"</table>"
	$body = $body & _
	"<hr></hr>" & _
	"<table>" & _
		"<tr>" & _
		"<td rowspan=" & Chr(34) & "2" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "high-templar" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "marine" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "hydralisk" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "sentry" & Chr(34) & "></td>" & _
		"<td rowspan=" & Chr(34) & "2" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "dark-templar" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "scv" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "drone" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "probe" & Chr(34) & "></td>" & _
		"<td rowspan=" & Chr(34) & "2" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "archon" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "none" & Chr(34) & ">X</span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "mutalisk" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "none" & Chr(34) & ">X</span></td>" & _
		"</tr>" & _
		"<tr>" & _
		"<!--1-->" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "ghost" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "roach" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "colossus" & Chr(34) & "></td>" & _
		"<!--2-->" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "raven" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "overseer" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "observer" & Chr(34) & "></td>" & _
		"<!--3-->" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "thor" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "ultralisk" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "immortal" & Chr(34) & "></td>" & _
		"</tr>" & _
		"</tr>" & _
		"</table>"
		$body = $body & _
		"<hr></hr>" & _
		"<table>" & _
		"<tr>" & _
		"<td rowspan=" & Chr(34) & "2" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "carrier" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "thor" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "mutalisk" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "phoenix" & Chr(34) & "></td>" & _
		"<td rowspan=" & Chr(34) & "2" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "tempest" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "swarm-host" & Chr(34) & ">" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "siege-tank" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "colossus" & Chr(34) & "></td>" & _
		"<td rowspan=" & Chr(34) & "2" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "oracle" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "scv" & Chr(34) & "></span></span>" & _
		"</td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "drone" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "strong" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "probe" & Chr(34) & "></td>" & _
		"</tr>" & _
		"<tr>" & _
		"<!--1-->" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "viking" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "corruptor" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "void-ray" & Chr(34) & "></td>" & _
		"<!--2-->" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "viking" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "corruptor" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "void-ray" & Chr(34) & "></td>" & _
		"<!--3-->" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "viking" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "mutalisk" & Chr(34) & "></td>" & _
		"<td class=" & Chr(34) & "weak" & Chr(34) & "><span class=" & Chr(34) & "unit-thumb-54x49" & Chr(34) & "><span class=" & Chr(34) & "phoenix" & Chr(34) & "></td>" & _
		"</tr>" & _
		"</tr>" & _
	"</table>" & _
	"<hr></hr>" & _
"</body>" & _
"</html>"

	EndSelect

	return $body
EndFunc