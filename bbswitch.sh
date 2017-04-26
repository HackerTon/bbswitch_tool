#!/bin/bash

ON_OFF=$1
BBSWITCH_LOC=/proc/acpi/bbswitch

if [ -f $BBSWITCH_LOC ]; then
	if grep ON $BBSWITCH_LOC >> /dev/null ; then
		echo "Turning OFF GPU"
		sudo rmmod nvidia
		sudo tee $BBSWITCH_LOC <<<OFF
	else
		echo "Turning ON GPU"
		sudo modprobe nvidia
		sudo tee $BBSWITCH_LOC <<<ON
	fi
else
	echo "CANNOT FIND "$BBSWTICH_LOC
fi
