#!/usr/bin/env bash
set -Ceu
#---------------------------------------------------------------------------
# 日本人の名字を除く名前を重複せずランダムに生成する。性別も出力する。
# CreatedAt: 2020-09-10
#---------------------------------------------------------------------------
Run() {
	THIS="$(realpath "${BASH_SOURCE:-0}")"; HERE="$(dirname "$THIS")"; PARENT="$(dirname "$HERE")"; THIS_NAME="$(basename "$THIS")"; APP_ROOT="$HERE";
	Help() { eval "echo \"$(cat "$HERE/doc/help.txt")\""; }
	Version() { cat "$APP_ROOT/doc/version.txt" | tail -n 1 | cut -f1; }
	Generate() { "$HERE/cmd/generate.sh" "$@"; }
	Select() { "$HERE/cmd/select.sh" "$@"; }
	Extract() { "$HERE/cmd/extract.sh" "$@"; }
	# サブコマンド解析
	# 1. 引数なし
	# 2. -h
	# 3. -v
	# 4. g
	# 5. s
	# 6. e
	# 7. 他
	IsExistArgs() { test $# -ne 0;  }
	! IsExistArgs "$@" && { Generate; exit 1; }
	case $1 in
		-h|--help) Help; exit 1; ;;
		-v|--version) Version; exit 1; ;;
		g|gen|generate|generator) Generate "${@:2:($#-1)}"; exit 1; ;;
		s|sel|select|selector) Select "${@:2:($#-1)}"; exit 1; ;;
		e|ext|extract|extractor) Extract "${@:2:($#-1)}"; exit 1; ;;
		\?) Help; exit 1; ;;
	esac
}
Run "$@"
