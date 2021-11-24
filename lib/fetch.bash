require configure

normalize_url() {
  local raw="${1}"
  shift

  if [[ "${raw}" =~ https?://.*\.c3tk ]]
  then echo "${raw}"
  else echo "${UPSTREAM}/config/${raw}.c3tk"
  fi
}

fetch_add() {
  local url="${1}"
  shift

  url=$(normalize_url $url)
  group=$(basename $url .c3tk)

  echo -n "Fetching ${url} ... "
  curl -f -s -o ${CONFIG_PATH}/config/${group}.c3tk $url 2>/dev/null || fail "transport error"
  echo "done"

  configure_group ${CONFIG_PATH}/config/${group}.c3tk
}

