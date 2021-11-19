run_container() {
  exec ${RUNTIME} run --rm -w '/w' -v "${PWD}:/w" -v "${HOME}:/root" "$@"
}
