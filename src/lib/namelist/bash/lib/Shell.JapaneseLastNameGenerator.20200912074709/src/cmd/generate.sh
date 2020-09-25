#!/usr/bin/env bash
set -Ceu
#---------------------------------------------------------------------------
# 日本人の名字を重複せずランダムに出力する。
# CreatedAt: 2020-09-12
#---------------------------------------------------------------------------
Run() {
	THIS="$(realpath "${BASH_SOURCE:-0}")"; HERE="$(dirname "$THIS")"; THIS_NAME="$(basename "$THIS")"; APP_ROOT="$(dirname "$HERE")";
	. "$APP_ROOT/lib/Error.sh"
	DB() { echo "$APP_ROOT/dic/surnames/one_to_many_yk.tsv"; }
	Help() { eval "echo \"$(cat "$APP_ROOT/doc/help_generate.txt")\""; }

	while getopts :n:u: OPT; do
		case $OPT in
			n) ARG_NUM="$OPTARG"; continue; ;;
			\?) Help; exit 1; ;;
		esac
	done
	ARG_NUM="${ARG_NUM:-30}"
	[ $ARG_NUM -eq 0 ] && exit 0
	CheckArgs() {
		IsInt() { test 0 -eq $1 > /dev/null 2>&1 || expr $1 + 0 > /dev/null 2>&1; }
		IsInt "$ARG_NUM" || { Throw '引数 n は1以上の自然数であるべきです。'; }
	}
	CheckArgs

	NUM=$ARG_NUM
	# 出力件数が負数なら全件出力する
	MAX_NUM="$(cat "$(DB)" | wc -l)"
	[ $ARG_NUM -lt 0 ] && NUM=$MAX_NUM
	# 出力件数が最大件数より多いなら全件出力する
	[ $MAX_NUM -lt $ARG_NUM ] && NUM=$MAX_NUM

	RAND=;
	[ $MAX_NUM -eq $NUM ] && RAND="$(cat "$(DB)")" || RAND="$(cat "$(DB)" | shuf -n $NUM)"
	KAKI="$(echo -e "$RAND" | xargs -I@ sh -c 'echo "@" | cut -f2 | tr "," "\n" | shuf -n 1')"
#	KAKI="$(echo -e "$RAND" | xargs -I@ -n64 -P4 sh -c 'echo "@" | cut -f2 | tr "," "\n" | shuf -n 1')"
#	KAKI="$(echo -e "$RAND" | parallel 'echo {} | cut -f2 | tr "," "\n" | shuf -n 1')"
	paste <(echo -e "$RAND" | cut -f1) <(echo -e "$KAKI")
}
Run "$@"
