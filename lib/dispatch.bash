require cmd

dispatch_cmd() {
  local cmd="${1}"
  shift

  gen_config

  case "${cmd}" in 
    (paths) paths ;;
    (add) add_cmd "$@" ;;
    (c3tk|help|--help|-h) usage ;;
    (configure) configure "${@}" ;;
    (fetch) fetch_add "${@}" ;;
    (list) installed_cmds ;;
    (info) info_cmds "$@";;
    (rm) rm_cmd "$@" ;;
    (shell) shell_for ${@} ;;
    (uninstall) uninstall ;;
    (*)
      cmd_exists ${cmd} || unknown "${cmd}"

      run_cmd ${cmd} ${@}
      ;;
  esac
}

