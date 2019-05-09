#!/bin/bash

function printogginfo ()
{
	filepath="$*"
	filename=${filepath##*/}
	oggtext=`ogginfo "$filepath"`


	title=`echo -n "$oggtext" | grep "TITLE=" | sed -e 's/TITLE=//' -e 's/^[[:blank:]]//g' -e 's/(demo)//' -e 's/[[:blank:]]$//'`
	genre=`echo -n "$oggtext" | grep "GENRE=" | sed -e 's/GENRE=//' -e 's/^[[:blank:]]//g'`
	htmlaudio="<audio controls preload=\"none\">\
  <source src=\"$filepath\" type=\"audio/ogg\">
  </audio>"

	echo "<tr bgcolor=\"#88cc99ff\">"

	echo "<td style=\"padding:16px\">"
	echo "  <font size=+1><b>" $title "</b></font><br>"
	echo "  <font size=-1><i>" $genre "</i></font>"
	echo "</td>"

	echo "<td style=\"padding:16px\">" $htmlaudio "</td>"

	echo "</tr>"
}

function printogginfo_m ()
{
	for p in $*
	do
		printogginfo $p
	done
}

TITLE=$1
SUBTITLE=$2
EMAIL=$3

echo '<html lang="ja">'
echo '<head> <meta charset="UTF-8"> </head>'
echo '<body>'
echo "<div style=\"text-align:center;display:block\">
	<h1>$TITLE</h1>
	<i>$SUBTITLE</i><br>
	</div>"
echo '<div style="text-align:center; width:100%">'
echo '<pre style="text-align:left; display:inline-block; padding:16px">'
echo '<table style="border:8px solid black">'

printogginfo_m ${@:4}

echo '</table>'
echo '</pre>'
echo '</div>'
echo "<div style=\"text-align:center;display:block\">
	<font size=+1>
  	  <b> [ <a href="mailto:$EMAIL">e-mail</a> ] </b>
	</font>
	</div>"
echo '</body>'
echo '</html>'
