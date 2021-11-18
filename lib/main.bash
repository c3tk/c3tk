require dispatch environment

usage() {
  cat <<-USAGE

c3tk <cmd> [OPTIONS|ARGS]

Where cmd is either one of:

  add <name> <image>
  fetch <url-to-.c3tk-file>
  configure
  list
  rm <name>
  shell <name>
  X - where X is a cmd that was added via \`add\` or configured via .c3tk files
  install
  update
  uninstall

USAGE
}

main() {

  [[ -z "${DEBUG}" ]] || set -xv && export DEBUG

  env_setup

  # Allow this script to be symlinked as the actual command name :)
  cmd="$1" ; [[ ${0//*\/} == "c3tk" ]] && shift || cmd="${0//*\/}"

  case "${cmd}" in
    # Install is a special case, so we handle it explicitly
    (install) install ;;

    # Ditto for update
    (update) update ;;

    # Pass everything else over to the distpacher
    (*) dispatch_cmd "${cmd}" "$@" ;;
  esac

  exit 0
}

