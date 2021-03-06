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
}

config_read() {
  local _cmd="$1" _key="$2"
  local _cmd_file="${CONFIG_PATH}/cmds/${_cmd}"
  awk -F= "/${_key}/{print \$2}" "${_cmd_file}"
}

configure_group() {
  local config="${1}"
  local group=$(basename ${config} '.c3tk')

  echo -e "\n${group}:\n$(printf '=%0.s' {1..80})"
  while read _line
  do
    echo " => ${_line}"
    ${0} ${_line}
  done < <(cat ${config} | sed -e '/^[[:blank:]]*#/d;s/#.*//')
}

configure() {
  local _config

  if defined "${1}"
  then
    configure_group ${1}
  else
    for _config in $(find "${CONFIG_PATH}"/config -iname '*.c3tk')
    do
      configure_group "${_config}"
    done
  fi
}

platform() {
  echo "${DIST:-$(config_read "${cmd}" "dist")}/${ARCH:-$(config_read "${cmd}" "arch")}"
}

