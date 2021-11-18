gen_config() {
  mkdir -p "${CONFIG_PATH}"/{bin,cmds,config} ${HOME}/.config

  # TODO: The below case needs to be handled
  touch ~/.saferc ~/.vaultrc ~/.flyrc
}

configure() {
  local _config _group
  for _config in $(find ~/.config/c3tk/config  -iname '*.c3tk')
  do
    _group=$(basename ${_config} '.c3tk')
    while read _line 
    do 
      echo " ${_group} => ${_line}"
      $0 $_line
    done < <(cat ${_config} | sed -e '/^[[:blank:]]*#/d;s/#.*//')
  done
}

