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
    (w|workspace) 
      _action="$1"
      shift
      case "${_action}" in
        (c|create) 
          workspace_create ${@} 
          ;;
        (a|attach) 
          workspace_attach ${@} 
          ;;
        (d|delete) 
          workspace_delete ${@} 
          ;;
        (p|pause) 
          workspace_pause ${@} 
          ;;
        (u|unpause) 
          workspace_unpause ${@} 
          ;;
        (*)
          workspace_usage
          ;;
      esac
      ;;
    (*)
      cmd_exists ${cmd} || unknown "${cmd}"

      run_cmd ${cmd} ${@}
      ;;
  esac
}

