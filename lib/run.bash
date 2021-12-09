run_cmd() {
  local cmd="$1" _c _image _tag _configs _m _mounts
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
      if grep -q 'stream' "${CONFIG_PATH}/cmds/${cmd}" && [[ -z "${WORKSPACE}" ]]
      then _c="${_c} --log-driver=none -a stdin -a stdout -a stderr "
      fi
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

  if [[ -n "${WORKSPACE}" ]]
  then
    _c="${_c} --name workspace-${WORKSPACE} -d "
  else
    _c="${_c} --rm "
  fi

  run_container --platform="$(platform)" ${_c} "${_image}:${_tag:-"latest"}" \
    "${_cmd:-"${cmd}"}" "$@"
}
