paths() {
  echo "${HOME}/.config/c3tk/bin:${INSTALL_PATH}"
}

env_setup() {
  true \
    "${CONFIG_PATH:="$HOME/.config/c3tk"}" \
    "${BIN_PATH:="${CONFIG_PATH}/bin"}" \
    "${IMAGE_TAG:="${TAG:-latest}"}"
}
