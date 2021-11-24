fail() {
  echo "FAIL: ${1}" >&2
  exit 255
}

require() {
  for lib in $@
  do
    # All libs are intended to be relative to c3tk.bash
    source $(dirname "${BASH_SOURCE[0]}")/${lib}.bash ||
      fail "Could not load '${lib}'"
  done
}

defined() {
  [[ -n "${1}" ]]
}

_c3tk_bootstrap() {
  # Load the list of all the things
  require libs

  # Load all the things
  require ${C3TK_LIBS[@]}
}
