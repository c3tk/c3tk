run_cmd() {
  local cmd="$1" _c _image _tag _configs _cmd
  shift

  _image="${IMAGE:-$(config_read "${cmd}" "image")}"
  _tag="${TAG:-$(config_read "${cmd}" "tag")}"
  _cmd="${CMD:-$(config_read "${cmd}" "cmd")}"
  _configs=($(config_read "${cmd}" "configs" | tr ',' ' '))

  _c="-i" # Default to allowing interactive
  grep -q 'stream' "${CONFIG_PATH}/cmds/${cmd}" &&
    _c="${_c} --log-driver=none -a stdin -a stdout -a stderr "

  grep -q 'tty' "${CONFIG_PATH}/cmds/${cmd}" && 
    _c="${_c} -t "

  run_container --platform="$(platform)" ${_c} "${_image}:${_tag:-"latest"}" \
    "${_cmd:-"${cmd}"}" "$@"
}
