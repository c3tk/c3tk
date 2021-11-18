cmd_exists() {
  local _cmd="${1}"
  [[ -s "${CONFIG_PATH}/cmds/${_cmd}" ]]
}

unknown() {
  fail "${1} not found, do you need to \`add\` it?"
}
