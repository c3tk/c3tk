workspace_usage() {
  cat <<-USAGE

A c3tk workspace is a long running interactive container session 

Usage:

    c3tk workspace <cmd> <action> [<name>]

Where:

  <cmd> is the name of an added cmd which dictates container image
  <action> is one of:
    a|attach - attach to a running workspace  
    c|create - create a workspace
    d|delete - delete a workspace
    p|pause  - pause a workspace
    u|unpause - unpause a workspace

    If <name> is supplied it is used as the container name, otherwise <cmd> is used.

NOTE: 

  workspace requires and expects \`/bin/bash\` to be available on the <cmd>'s image.

USAGE
exit 0
}

require cmd

set_workspace() {
  local _cmd="$1"

  WORKSPACE="$2"
  if [[ -n "${WORKSPACE}" ]] 
  then shift 2
  else WORKSPACE="${_cmd}"
  fi
}

workspace_attach() {
  local _cmd="$1"
  set_workspace "${_cmd}"
  ${RUNTIME} exec -it workspace-${WORKSPACE} /bin/bash
}

workspace_running() {
  if [[ -z "$(${RUNTIME} ps | awk '$NF == "'workspace-${WORKSPACE}'" {print $NF}')" ]]
  then return 1
  else return 0
  fi
}

workspace_create() {
  local _cmd="$1"
  set_workspace "${_cmd}"
  if ! workspace_running
  then
    CMD=/bin/bash run_cmd ${_cmd} "-c" 'while true ; do sleep 3600 ; done' && 
    echo "workspace created"
  else
    echo "workspace already created"
  fi

}

workspace_delete() {
  local _cmd="$1"
  set_workspace "${_cmd}"
  ${RUNTIME} stop workspace-${WORKSPACE}
  ${RUNTIME} rm workspace-${WORKSPACE}
  echo "workspace deleted"
}

workspace_pause() {
  local _cmd="$1"
  set_workspace "${_cmd}"
  ${RUNTIME} pause workspace-${WORKSPACE}
  echo "workspace paused"
}

workspace_unpause() {
  local _cmd="$1"
  set_workspace "${_cmd}"
  ${RUNTIME} unpause workspace-${WORKSPACE}
  echo "workspace unpause"
}

workspace_list() {
  local _cmd="$1"
  set_workspace "${_cmd}"
  echo -e "\nWorkspaces\n$(printf '=%.0s' {1..80})"
  ${RUNTIME} ps | awk '{print $NF}' | awk '/workspace-/'
}

