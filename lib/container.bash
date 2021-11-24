run_container() {
  local _tty
  [[ "$(tty)" =~ ^not*  ]] && _tty="" || _tty="-t"
  exec ${RUNTIME} run --rm ${_tty} -w /w -e HOME=/u \
    -v "${PWD}:/w" -v "${HOME}:/u" "$@"
}
