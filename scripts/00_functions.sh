RED=31
GREEN=32
YELLOW=33

function log() {
  color=$1
  shift
  status=$1
  shift
  echo -e "[ \033[${color}m${status}\033[m ] $@"
}
function log_done() {
  log ${GREEN} "DONE" $@
}
function log_skip() {
  log ${YELLOW} "SKIP" $@
}
function log_fail() {
  log ${RED} "FAIL" $@
}
