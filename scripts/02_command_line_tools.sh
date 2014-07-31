package="Install Command Line Developer Tools"

function install_xcode(){
  xcode-select --install
  while true
  do
    sleep 3
    pgrep ${package} >/dev/null 2>&1
    if [ $? != 0 ]; then
      break
    fi
  done
  xcode-select -p
  if [ $? != 0 ]; then
    log_fail ${package}
  fi
}

xcode-select -p >/dev/null 2>&1
if [ $? != 0 ]; then
  install_xcode
  log_done ${package}
else
  log_skip ${package}
fi
