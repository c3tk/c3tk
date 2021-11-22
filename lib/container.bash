run_container() {
  [[ "*not*" == "$(tty)" ]] || _tty="-t"
  exec ${RUNTIME} run --rm ${_tty:-} -w '/w' -v "${PWD}:/w" -v "${HOME}:/root" "$@"
}
