image_for() {
  local cmd="${1}"

  if [[ -z "${cmd}" ]]
    then
      echo "wayneeseguin/c3tk"
    else
      awk -F= '/image=/{print $2}' ${CONFIG_PATH}/cmds/${cmd}
  fi
}

docker_run() {
  exec docker run --rm --platform="linux/amd64" -w '/w' -v ${PWD}:/w "$@"
}
