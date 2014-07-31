package="Update PATH"

if [[ ! `echo ${PATH} | grep -e /usr/local/bin` ]]; then
  export PATH="/usr/local/bin:${PATH}"
  log_done ${package}
else
  log_skip ${package}
fi
