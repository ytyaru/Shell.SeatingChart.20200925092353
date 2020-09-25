#!/usr/bin/env bash
set -Ceu
#---------------------------------------------------------------------------
# 座席表をランダム生成する。
# CreatedAt: 2020-09-25
#---------------------------------------------------------------------------
Run() {
	THIS="$(realpath "${BASH_SOURCE:-0}")"; HERE="$(dirname "$THIS")"; PARENT="$(dirname "$HERE")"; THIS_NAME="$(basename "$THIS")"; APP_ROOT="$PARENT";
	cd "$HERE"
	. "$APP_ROOT/src/lib/IsSQLite3VerOrLater.sh"
	Help() { eval "echo \"$(cat "$APP_ROOT/res/doc/help.txt")\""; }
	NameListPath() { echo "$APP_ROOT/src/lib/namelist/$1/NameList.sh"; }
	ChangeSeatsPath() { echo "$APP_ROOT/src/lib/changeseats/ChangeSeats.sh"; }
	Tsv2HtmlPath() { echo "$APP_ROOT/src/lib/tsv2html.sh"; }
	IsSQLite3VerOrLater '3.25.0' '窓関数を使用するため。' && { NAMELIST_PATH=$(NameListPath 'sqlite3'); } || { NAMELIST_PATH=$(NameListPath 'bash'); }
	while getopts :n:s: OPT; do
		case $OPT in
			n) ARG_NUM="$OPTARG"; continue; ;;
			s) ARG_SORT_METHOD="$OPTARG"; continue; ;;
			*) Help; exit 1; ;;
		esac
	done
	ARG_NUM="${ARG_NUM:-40}"
	ARG_SORT_METHOD="${ARG_SORT_METHOD:-a}"
	"$NAMELIST_PATH" "$ARG_NUM" | "$(ChangeSeatsPath)" -m "$ARG_SORT_METHOD" | "$(Tsv2HtmlPath)"
}
Run "$@"
