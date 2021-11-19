info_usage() {
  cat <<-USAGE

Usage:

    c3tk rm <cmd> [<cmd>[, ...]]

Description:

    Removes one or more listed commands.

USAGE
exit 0
}

info_cmds() {
  (( $# > 0  )) || info_usage
  for _cmd in "$@"
  do
    echo -e "${_cmd}:\n$(printf '=%.0s' {1..80})"
    if [[ -s "${CONFIG_PATH}/cmds/${_cmd}" ]] 
    then 
      echo "bin=${CONFIG_PATH}/bin/${_cmd}" 
      cat "${CONFIG_PATH}/cmds/${_cmd}" 
    fi
  done
}

