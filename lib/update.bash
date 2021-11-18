update_usage() {
  cat <<-USAGE

Usage:

    c3tk update

Description:

    Updates c3tk from via https://github.com/c3tk/c3tk

USAGE
exit 0
}

update() {
  rm -f ${INSTALL_PATH}/c3tk &&
    rm -rf ${LIB_PATH:-"/opt/c3tk/lib"}/* &&
    install
}
