#!/usr/bin/env bash
IsSQLite3VerOrLater() { # $1:期待バージョン('3.25.0'等), $2:そのバージョンを使用すべき理由
	NOW_VER="$(sqlite3 -batch -interactive --version | tr ' ' '\t' | cut -f1)"
	OLD_VER="$(cat <(echo "$1") <(echo "$NOW_VER") | sort -V)"
	URL_VER=$(echo "$1" | tr '.' '_')
	[ "$NOW_VER" = "$OLD_VER" -a "$NOW_VER" != "$1" ] && { return 1; } || { return 0; }
#	[ "$NOW_VER" = "$OLD_VER" -a "$NOW_VER" != "$1" ] && { Throw 'SQLite3のバージョンは'"$1"'以上であるべきです。'"${2:-}"': https://www.sqlite.org/releaselog/'"$URL_VER"'.html'; }
}
#IsSQLite3VerOrLater '3.25.0' '窓関数を使用するため。'
#IsSQLite3VerOrLater '3.33.0' '.mode jsonを使用するため。'
