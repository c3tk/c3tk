shell_usage() {
  cat <<-USAGE

Usage:

    c3tk shell <cmd>

Description:

    Launches an interaticve shell (bash) session using the <cmd>'s container image.

USAGE
exit 0
}

require cmd docker

shell_for() {
  local cmd="${1}"
  shift

  [[ "" == "${cmd}" ]] || cmd_exists "${cmd}" || unknown "${cmd}"
  image=$(image_for "${cmd}")
  docker_run -it -v $HOME/:/root "${image}" bash "$@"
}

