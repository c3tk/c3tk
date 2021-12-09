workspace_usage() {
  cat <<-USAGE

Usage:

    c3tk workspace <cmd> [<name>]

Description:

    Launches a long running interactive workspace (bash) session 

    If <name> is supplied it is used as the container name, otherwise <cmd> is used.

    NOTE: This requires and expects \`/bin/bash\` to be available on the <cmd>'s image.

USAGE
exit 0
}

require cmd

workspace_for() {
  local _cmd="$1"
  WORKSPACE="$2"
  if [[ -n "${WORKSPACE}" ]] 
  then shift 2
  else WORKSPACE="${_cmd}"
  fi

  if [[ -n "$(docker ps | awk '$NF == "'workspace-${WORKSPACE}'" {print $NF}')" ]]
  then 
    docker exec -it workspace-${WORKSPACE} /bin/bash
  else
    CMD=/bin/bash run_cmd ${_cmd} "-c" 'while true ; do sleep 3600 ; done'

    docker exec -it workspace-${WORKSPACE} /bin/bash
  fi
}
