#!/usr/bin/env bash
set -Ceu
#---------------------------------------------------------------------------
# TSVをHTMLに変換する。
# CreatedAt: 2020-09-18
#---------------------------------------------------------------------------
Run() {
	THIS="$(realpath "${BASH_SOURCE:-0}")"; HERE="$(dirname "$THIS")"; PARENT="$(dirname "$HERE")"; THIS_NAME="$(basename "$THIS")"; APP_ROOT="$(dirname "$PARENT")";
	ToHtml() { echo '<html>'"$1"'</html>'; }
	ToHtmlCss() { echo '<style type="text/css">'"$1"'</style>'; }
	ToHtmlCssLink() { echo '<link href="'"$APP_ROOT/res/main.css"'" rel="stylesheet" type="text/css">'; }
	ToHtmlRoom() { echo '<div id="schoolroom">'"$1"'</div>'; }
	ToHtmlDesk() { echo '<div class="'"$2"'">'"$1"'</div>'; }
	ToHtmlRuby() { echo '<ruby>'"$2"'<rt>'"$1"'</rt></ruby>'; }
	NAMES=()
	IFS=$'\n'
	for LINE in $(cat -); do
		N="$(echo -e "$LINE" | cut -f1)"
		LY="$(echo -e "$LINE" | cut -f2)"
		LK="$(echo -e "$LINE" | cut -f4)"
		FY="$(echo -e "$LINE" | cut -f3)"
		FK="$(echo -e "$LINE" | cut -f5)"
		S="$(echo -e "$LINE" | cut -f6)"
		NAMES+=("$(ToHtmlDesk "$(ToHtmlRuby "$LY" "$LK")<span> </span>$(ToHtmlRuby "$FY" "$FK")" $S)")
	done
	HTML="$(ToHtmlCss "$(cat "$APP_ROOT/res/css/main.css" | tail -n +2 )")"
	HTML+="$(ToHtmlRoom "$(IFS=$'\n'; echo "${NAMES[*]}")")"
	HTML="$(ToHtml "$HTML")"
	echo -e "$HTML"
	zenity --text-info --html --title='yyyy年度　○○中学校　○年○組　座席表' --width=1200 --height=300 --filename=<(echo "$HTML")
}
Run
