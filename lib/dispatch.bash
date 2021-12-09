require cmd

dispatch_cmd() {
  local cmd="${1}"
  shift

  gen_config

  case "${cmd}" in 
    (a|add) add_cmd "$@" ;;
    (c3tk|help|--help|-h) usage ;;
    (configure) configure "${@}" ;;
    (f|fetch) fetch_add "${@}" ;;
    (i|info) info_cmds "$@";;
    (l|list) installed_cmds ;;
    (paths) paths ;;
    (rm) rm_cmd "$@" ;;
    (shell) shell_for ${@} ;;
    (uninstall) uninstall ;;
    (w|workspace) workspace_for ${@} ;;
    (*)
      cmd_exists ${cmd} || unknown "${cmd}"

      run_cmd ${cmd} ${@}
      ;;
  esac
}

