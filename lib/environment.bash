paths() {
  echo "${HOME}/.c3tk/bin:${INSTALL_PATH}"
}

find_runtime() {
  local _runtime=$(which docker)
  [[ -n "${_runtime}" ]] || _runtime=$(which podman)
  [[ -z "${_runtime}" ]] || echo "${_runtime}"
}

env_setup() {
  true \
    "${CONFIG_PATH:="$HOME/.c3tk"}" \
    "${BIN_PATH:="${CONFIG_PATH}/bin"}" \
    "${IMAGE_TAG:="${TAG:-latest}"}" \
    "${DIST:="linux"}" \
    "${ARCH:="amd64"}" \
    "${RUNTIME:="${RUNTIME:-"$(find_runtime)"}"}"

  command -v ${RUNTIME} &>/dev/null || 
    raise "No runtime found in path, install docker or podman"
}
