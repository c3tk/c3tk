uninstall() {
  if [[ -d "${OPT_PATH:="/opt/c3tk"}" ]]
  then 
    echo "Removing "${OPT_PATH}", /usr/local/bin/c3tk..."
    sudo rm -rf "${OPT_PATH}" /usr/local/bin/c3tk
  fi
  
  echo "Removing ~/.config/c3tk..."
  rm -rf ~/.config/c3tk
  echo "c3tk uninstalled."
}
