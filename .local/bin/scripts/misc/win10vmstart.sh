#!/bin/bash
# set -xe
xdotool key super+0
virsh --connect qemu:///system start "win10-sat" && virt-manager --connect \
	qemu:///system --show-domain-console "win10-sat"
