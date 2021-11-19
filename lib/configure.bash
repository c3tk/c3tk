configure_usage() {
  cat <<-USAGE

Usage:

    c3tk configure

Description:

    Configure loads all ~/.c3tk/config/*.c3tk files

USAGE
exit 0
}

gen_config() {
  mkdir -p "${CONFIG_PATH}"/{bin,cmds,config}

  # TODO: The below case needs to be handled
  touch ~/.saferc ~/.vaultrc ~/.flyrc
}

configure() {
  local _config _group
  for _config in $(find ~/.c3tk/config  -iname '*.c3tk')
  do
    _group=$(basename ${_config} '.c3tk')
    echo -e "\n${_group}:\n$(printf '=%.0s' {1..80})"
    while read _line 
    do 
      echo " => ${_line}"
      $0 $_line
    done < <(cat ${_config} | sed -e '/^[[:blank:]]*#/d;s/#.*//')
  done
}

