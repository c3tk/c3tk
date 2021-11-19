rm_usage() {
  cat <<-USAGE

Usage:

    c3tk rm <cmd> [<cmd>[, ...]]

Description:

    Removes one or more listed commands.

USAGE
exit 0
}

rm_cmd() {
  for _cmd in "${@}"
  do
    if [[ -s "${CONFIG_PATH}/cmds/${_cmd}" ]] 
    then rm "${CONFIG_PATH}/cmds/${_cmd}" 
    fi

    if [[ -L "${BIN_PATH}/${_cmd}" ]] 
    then  rm "${BIN_PATH}/${_cmd}"
    fi
  done
}

