#!/usr/bin/env bash
set -Ceu
#---------------------------------------------------------------------------
# 日本人の名字を除く名前を重複せずランダム出力する。
# CreatedAt: 2020-09-11
#---------------------------------------------------------------------------
Run() {
	THIS="$(realpath "${BASH_SOURCE:-0}")"; HERE="$(dirname "$THIS")"; THIS_NAME="$(basename "$THIS")"; APP_ROOT="$(dirname "$HERE")";
	. "$APP_ROOT/lib/Error.sh"
	. "$APP_ROOT/lib/Db.sh"
	Help() { eval "echo \"$(cat "$APP_ROOT/doc/help_generate.txt")\""; }
	while getopts :n:s:r: OPT; do
		case $OPT in
			n) ARG_NUM="$OPTARG"; continue; ;;
			s) ARG_SEX="$OPTARG"; continue; ;;
			r) ARG_RATE="$OPTARG"; continue; ;;
			\?) Help; exit 1; ;;
		esac
	done
	ARG_NUM="${ARG_NUM:-30}"
	ARG_SEX="${ARG_SEX:-*}"
	ARG_RATE="${ARG_RATE:-E}"
	[ $ARG_NUM -eq 0 ] && exit 0
	CheckArgs() {
		IsInt() { test 0 -eq $1 > /dev/null 2>&1 || expr $1 + 0 > /dev/null 2>&1; }
		IsInt "$ARG_NUM" || { Throw '引数 n は整数であるべきです。'; }
		IsSex() {
			case "$1" in
				m|f|c|mc|fc|cm|mc|M|F|C|'*') return 0;;
				*) return 1;;
			esac
		}
		IsSex "$ARG_SEX" || { Throw '引数 s は m f c mc fc cm mc M F C * のいずれかであるべきです。'; }
		IsRate() {
			case "$1" in
				e|E) return 0;;
				*) return 1;;
			esac
		}
		IsRate "$ARG_RATE" || { Throw '引数 r は e E のいずれかであるべきです。'; }
	}
	CheckArgs

	DB="$(DB yk om "$ARG_SEX")"
	NUM=$ARG_NUM
	# 出力件数が負数なら全件出力する
	MAX_NUM="$(echo -e "$DB" | wc -l)"
	[ $ARG_NUM -lt 0 ] && NUM=$MAX_NUM
	# 出力件数が最大件数より多いなら全件出力する
	[ $MAX_NUM -lt $ARG_NUM ] && NUM=$MAX_NUM

	# 性別制約が男女混合なら半々にする(出力件数が奇数の時は男女共通名を1件追加する。出力件数が1件のときは男女共通名1件のみ出力する)
	random_yomi_mix() {
		[ 1 -eq $NUM ] && { echo -e "$(DB_SEX 1 c)"; return; }
		HALF_NUM=$(($NUM / 2))
		[ $(($NUM % 2)) -eq 0 ] && {
#			cat <(echo -e "$(DB_SEX $(($NUM / 2)) $1)") <(echo -e "$(DB_SEX $(($NUM / 2)) $2)")
#			cat <(DB_SEX $(($NUM / 2)) $1) <(DB_SEX $(($NUM / 2)) $2)
			cat <(DB_SEX $HALF_NUM $1) <(DB_SEX $HALF_NUM $2)
		} || {
#			cat <(echo -e "$(DB_SEX $(($NUM / 2)) $1)") <(echo -e "$(DB_SEX $(($NUM / 2)) $2)") <(echo -e "$(DB_SEX 1 c)")
			cat <(DB_SEX $HALF_NUM $1) <(DB_SEX $HALF_NUM $2) <(DB_SEX 1 c)
		}
	}
	[ '*' = "$ARG_SEX" ] && {
		case "$ARG_RATE" in
			e) RANDOM_YOMI="$(random_yomi_mix m f)";;
			E) RANDOM_YOMI="$(random_yomi_mix M F)";;
		esac
	} || { RANDOM_YOMI="$(DB_SEX $NUM $ARG_SEX)"; }

	# 各「読み」にあたる「表記」をランダムに1件取得する
	KAKI="$(echo -e "$RANDOM_YOMI" | xargs -I@ sh -c 'echo -e "@" | cut -f2 | tr "," "\n" | shuf -n 1')"

	# 「読み\t表記」のように列結合した結果を出力する
	paste <(echo -e "$RANDOM_YOMI" | cut -f1) <(echo -e "$KAKI") <(echo -e "$RANDOM_YOMI" | cut -f3)
}
Run "$@"
