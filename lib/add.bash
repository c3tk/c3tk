add_usage() {
  cat <<-USAGE
c3tk add <name> image=<img> [tag=<tag>] [tty] [stream]

Where:
   name    - command name to expose to the host system
   tag     - image tag to use, defaults to :latest
   image   - docker compatible registry url
   tty     - if present will add '-t' 
   stream  - if present will add '--log-driver=none -a stdin -a stdout -a stderr'

USAGE
exit 0
}

add_cmd() {
  (( $# > 1 )) || fail "$(add_usage)"

  local _cmd _image _tag target_path
  _cmd="$1" && shift || fail "$(add_usage)"
  # TODO: If empty check if definition file already exists, if so symlink.
  if (( $# > 0 ))
  then
    echo "" > ${CONFIG_PATH}/cmds/${_cmd}
    for arg in "${@}" 
    do 
      case "${arg}" in
        (image=*)
          _image=$(echo ${arg} | awk -F= '{print $2}')
          ;;
        (tag=*)
          _tag=$(echo ${arg} | awk -F= '{print $2}')
          [[ -n "${_tag}" ]] || _tag="latest"
          ;;
      esac
      if ! grep -sqwF "${arg}" "${CONFIG_PATH}/cmds/${_cmd}"; then
        echo "${arg}" >> ${CONFIG_PATH}/cmds/${_cmd}
      fi
    done
    [[ -n "${_image}" ]] || fail "Image Required"
  else
    if [[ -s ${CONFIG_PATH}/cmds/${_cmd} ]]
    then
      _image=$(awk -F= '/image=/{print $2}' ${CONFIG_PATH}/cmds/${cmd})
      _tag=$(awk -F= '/tag=/{print $2}' ${CONFIG_PATH}/cmds/${cmd})
    fi
    [[ -n "${_image}" ]] || fail "$(add_usage)"
  fi
  target_path="${BIN_PATH}"

  ln -fs ${INSTALL_PATH}/c3tk ${target_path}/${_cmd}
  docker pull --platform="linux/amd64" ${_image}:${_tag:-latest}
}

