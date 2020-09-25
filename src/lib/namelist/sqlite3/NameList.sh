#!/usr/bin/env bash
set -Ceu
#---------------------------------------------------------------------------
# クラス名簿をランダム生成する。
# CreatedAt: 2020-09-25
#---------------------------------------------------------------------------
Run() {
	THIS="$(realpath "${BASH_SOURCE:-0}")"; HERE="$(dirname "$THIS")"; PARENT="$(dirname "$HERE")"; THIS_NAME="$(basename "$THIS")"; APP_ROOT="$PARENT";
	cd "$HERE/Sqlite3.JapaneseNames.Rate.20200924163636/src"
	./run.sh "$@"
}
Run "$@"
