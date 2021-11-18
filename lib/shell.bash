require cmd docker

shell_for() {
  local cmd="${1}"
  shift

  [[ "" == "${cmd}" ]] || cmd_exists "${cmd}" || unknown "${cmd}"
  image=$(image_for "${cmd}")
  docker_run -it -v $HOME/:/root "${image}" bash "$@"
}

