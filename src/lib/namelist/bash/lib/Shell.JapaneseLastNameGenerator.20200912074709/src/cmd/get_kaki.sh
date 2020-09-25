#!/usr/bin/env bash
set -Ceu
#---------------------------------------------------------------------------
# 指定した「読み」の「表記」を全パターン取得する。
# CreatedAt: 2020-09-12
#---------------------------------------------------------------------------
Run() {
	THIS="$(realpath "${BASH_SOURCE:-0}")"; HERE="$(dirname "$THIS")"; THIS_NAME="$(basename "$THIS")"; APP_ROOT="$(dirname "$HERE")";
	. "$APP_ROOT/lib/Error.sh"
	DB_OM_KY() { echo "$APP_ROOT/dic/surnames/one_to_many_ky.tsv"; }
	DB_OM_YK() { echo "$APP_ROOT/dic/surnames/one_to_many_yk.tsv"; }
	DB_OO_YK() { echo "$APP_ROOT/dic/surnames/one_to_one_yk.tsv"; }

	[ $# -lt 1 ] && { Throw '取得したい「表記」の「読み」を第1引数に指定してください。'; }
	IFS=$'¥n'
	KAKI="$(cat "$(DB_OM_YK)" | awk -F "\t" '$1 == "'"$1"'" {print $2}' | tr ',' '\n')"
	[ -n "$KAKI" ] && { echo -e "$KAKI"; exit 0; }
	cat "$(DB_OO_YK)" | awk -F "\t" '$1 == "'"$1"'" {print $2}'
}
Run "$@"
