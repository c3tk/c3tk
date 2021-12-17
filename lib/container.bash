run_container() {
  local _tty
  [[ "$(tty)" =~ ^not*  ]] && _tty="" || _tty="-t"
  ${RUNTIME} run ${_tty} -w /w -e HOME=/u \
    -v "${PWD}:/w" -v "${HOME}:/u" -v "/tmp:/tmp" "$@"
}
