#!/bin/bash
VMWARE='/Applications/VMware\ Fusion.app/Contents/Library/vmrun'
VMPATH=~/Virtual\ Machines.localized
machine_list=(01 02 03 04)

cmd=$1
machine=$2

log_info() {
    echo -e "\033[32m$1\033[0m\n"
}

hardstop() {
  log_info "Machine $1 stoping..."
  sh -c "$VMWARE -T fusion stop '$VMPATH/$1.vmwarevm' hard"
  log_info "Machine $1 stoped"
}

hardstopall() {
  for i in "${machine_list[@]}"
  do
    hardstop k8s$i
  done
}

start() {
  log_info "Machine $1 starting..."
  sh -c "$VMWARE -T fusion start '$VMPATH/$1.vmwarevm' nogui"
  log_info "Machine $1 started"
}

startall() {
  for i in "${machine_list[@]}"
  do
    start k8s$i
  done
}

case $cmd in
  stop)
    if [ -n "$machine" ]; then
      hardstop $machine
    else
      hardstopall
    fi
  ;;
  start)
    if [ -n "$machine" ]; then
      start $machine
    else
      startall
    fi
  ;;
  *)
    echo '
Usage
vmctl cmd [machine_name]

vmctl start               # start all machine
vmctl start k8s01         # start spec machine named k8s01
vmctl stop                # stop hard all machine
vmctl stop k8s01          # stop spec machine named k8s01
'
  ;;
esac
