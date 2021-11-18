run_cmd() {
  local cmd="${1}"
  local _c=""
  shift

  _image=$(awk -F= '/image/{print $2}' "${CONFIG_PATH}/cmds/${cmd}")
  _tag=${TAG:-$(awk -F= '/tag/{print $2}' "${CONFIG_PATH}/cmds/${cmd}")}
  _configs=($(awk -F= '/configs/{print $2}' "${CONFIG_PATH}/cmds/${cmd}" | tr ',' ' '))
  _cmd=($(awk -F= '/cmd/{print $2}' "${CONFIG_PATH}/cmds/${cmd}" ))
  grep -q 'stream' "${CONFIG_PATH}/cmds/${cmd}" &&
    _c="${_c} --log-driver=none -a stdin -a stdout -a stderr "
  grep -q 'tty' "${CONFIG_PATH}/cmds/${cmd}" && 
    _c="${_c} -t "

  docker_run -i ${_c} "${_image}:${_tag:-latest}" "${_cmd:-"${cmd}"}" "$@"
}
