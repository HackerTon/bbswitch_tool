#!/bin/bash

ON_OFF=$1
BBSWITCH_LOC=/proc/acpi/bbswitch

if [ -f $BBSWITCH_LOC ]; then
	if grep ON $BBSWITCH_LOC >> /dev/null ; then
		echo "Turning OFF GPU"	
		sudo rmmod nvidia_uvm
		sudo rmmod nvidia_modeset
		sudo rmmod nvidia
		sudo tee $BBSWITCH_LOC <<<OFF	
	else
		echo "Turning ON GPU"
		sudo tee $BBSWITCH_LOC <<<ON
		sudo modprobe nvidia
		sudo modprobe nvidia_modeset
		sudo modprobe nvidia_uvm
	
	fi
else
	echo "CANNOT FIND "$BBSWTICH_LOC
fi
