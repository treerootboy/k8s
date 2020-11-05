#!/bin/bash
VMWARE=/Applications/VMware\ Fusion.app/Contents/Library/vmrun
VMPATH=~/Virtual\ Machines.localized
machine_list={1..4}

cmd=$1
machine=$2

hardstop() {
  $VMWARE -T fusion stop $VMPATH/$1.vmwarevm hard
}

hardstopall() {
  for i in $machine_list
  do
    hardstop k8s$i
  done
}

start() {
  $VMWARE -T fusion start $VMPATH/$1.vmwarevm nogui
}

startall() {
  for i in $machine_list
  do
    start k8s$i
  done
}

case $cmd
  stop)
    if [ -n $machine ]; then
      hardstop $machine
    else
      hardstopall
    fi
  ;;
  start)
    if [ -n $machine ]; then
      start $machine
    else
      startall
    fi
  ;;
 esac
 
 
 
 
