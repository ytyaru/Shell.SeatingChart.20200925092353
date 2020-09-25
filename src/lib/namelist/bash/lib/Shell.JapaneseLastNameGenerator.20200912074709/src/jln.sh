#!/usr/bin/env bash
set -Ceu
#---------------------------------------------------------------------------
# 日本人の名字をランダム出力・指定抽出する。
# CreatedAt: 2020-09-12
#---------------------------------------------------------------------------
Run() {
	THIS="$(realpath "${BASH_SOURCE:-0}")"; HERE="$(dirname "$THIS")"; THIS_NAME="$(basename "$THIS")"; APP_ROOT="$HERE";
	Help() { eval "echo \"$(cat "$HERE/doc/help.txt")\""; }
	Version() { cat "$APP_ROOT/doc/version.txt" | tail -n 1 | cut -f1; }
	Generate() { "$HERE/cmd/generate.sh" "$@"; }
	Select() { "$HERE/cmd/select.sh" "$@"; }
	Extract() { "$HERE/cmd/extract.sh" "$@"; }
	Yomi() { "$HERE/cmd/get_yomi.sh" "$@"; }
	Kaki() { "$HERE/cmd/get_kaki.sh" "$@"; }
	# サブコマンド解析
	# 1. 引数なし
	# 2. -h, -v
	# 3. g, s, e, y, k
	# 4. 他
	IsExistArgs() { test $# -ne 0;  }
	! IsExistArgs "$@" && { Generate; exit 1; }
	case $1 in
		-h|--help) Help; exit 1; ;;
		-v|--version) Version; exit 1; ;;
		g|gen|generate|generator) Generate "${@:2:($#-1)}"; exit 1; ;;
		s|sel|select|selector) Select "${@:2:($#-1)}"; exit 1; ;;
		e|ext|extract|extractor) Extract "${@:2:($#-1)}"; exit 1; ;;
		y|yomi) Yomi "${@:2:($#-1)}"; exit 1; ;;
		k|kaki) Kaki "${@:2:($#-1)}"; exit 1; ;;
		\?) Help; exit 1; ;;
	esac
}
Run "$@"
