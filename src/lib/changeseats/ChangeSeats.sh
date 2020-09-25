#!/usr/bin/env bash
set -Ceu
#---------------------------------------------------------------------------
# TSVの行順序を入れ替える（席替え）。
# CreatedAt: 2020-09-25
#---------------------------------------------------------------------------
Run() {
	THIS="$(realpath "${BASH_SOURCE:-0}")"; HERE="$(dirname "$THIS")"; PARENT="$(dirname "$HERE")"; THIS_NAME="$(basename "$THIS")"; APP_ROOT="$HERE";
	"$APP_ROOT/Shell.ChangeSeats.20200925075101/src/ChangeSeats.sh" "$@"
}
Run "$@"
