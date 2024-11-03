#!/usr/bin/env bash
# set -xe

# Imports
. ~/.local/share/univ/vars

vms_name=$(virsh list --all | awk '{print $2}' | xargs | cut -d ' ' -f2- | \
    sort | tr ' ' "\n" | $dmdpy "Select VM:")
action=$(printf "Start\\nShutdown\\nForce shutdown\\nRestart\\n" | \
	$dmdpy "Select action:")

start() {
	xdotool key super+0
	virsh -c qemu:///system start "$1" && virt-manager -c \
		qemu:///system --show-domain-console "$1"
	notify-send "VM Info system" "Domain "$1" started" --urgency=normal
}

shutdown() {
	virsh shutdown "$1" --mode acpi
	notify-send "VM Info system" "Domain "$1" is being shutdown" --urgency=normal
}

f_shutdown() {
	virsh destroy "$1"
	notify-send "VM Info system" "Initiated forced shutdown on domain "$1"" --urgency=normal
}

restart() {
	virsh reboot "$1"
	notify-send "VM Info system" "Domain "$1" is being restarted" --urgency=normal
}

case "${action[@]}" in 
	"Start")
		start $vms_name
		;;
	"Shutdown")
		shutdown $vms_name
		;;
	"Force shutdown")
		start $vms_name
		;;
	"Restart")
		restart $vms_name
		;;
	*)
		notify-send "VM Info system" "No Action selected" --urgency=normal
		;;
esac
