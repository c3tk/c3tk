shell_usage() {
  cat <<-USAGE

Usage:

    c3tk shell <cmd>

Description:

    Launches an interactive shell (bash) session using the <cmd>'s container image.

USAGE
exit 0
}

require cmd container

shell_for() {
  local cmd="$1"
  shift
  [[ "" == "${cmd}" ]] || cmd_exists "${cmd}" || unknown "${cmd}"
  image=$(config_read "${cmd}" image)
  run_container -it --platform="$(platform)" "${image}" bash "$@"
}

