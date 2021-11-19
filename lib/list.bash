list_usage() {
  cat <<-USAGE

Usage:

    c3tk list

Description:

    Lists all added commands avilaable

USAGE
exit 0
}

installed_cmds() {
  find "${CONFIG_PATH}/cmds" -mindepth 1 -maxdepth 1 -type f | 
    sed -e "s#${CONFIG_PATH}/cmds/##" | sort
}

