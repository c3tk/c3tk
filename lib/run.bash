run_cmd() {
  local cmd="$1" _c _image _tag _configs _cmd _m _mounts
  shift

  _image="${IMAGE:-$(config_read "${cmd}" "image")}"
  _tag="${TAG:-$(config_read "${cmd}" "tag")}"
  _cmd="${CMD:-$(config_read "${cmd}" "cmd")}"
  _configs=($(config_read "${cmd}" "configs" | tr ',' ' '))
  _mounts=($(config_read "${cmd}" "mounts" | tr ',' ' '))
  _envs=($(config_read "${cmd}" "envs" | tr ',' ' '))

  _c="-i" # Default to allowing interactive
  case ${RUNTIME} in
    (*docker*)
      grep -q 'stream' "${CONFIG_PATH}/cmds/${cmd}" && _c="${_c} --log-driver=none -a stdin -a stdout -a stderr "
      ;;
    (*podman*)
      _c="${c} -q"
      ;;
    (*)
      ;;
  esac

  for _env in "${_envs[@]}"
  do  _c="${_c} -e ${_env}='$(printenv ${_env})' "
  done

  for _m in "${_mounts[@]}"
  do _c="${_c} -v ${_m} "
  done

  run_container --platform="$(platform)" ${_c} "${_image}:${_tag:-"latest"}" \
    "${_cmd:-"${cmd}"}" "$@"
}
