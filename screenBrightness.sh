#!/bin/bash
# Written by Wilson Nandolo.
# Computer secondary screen brightness. This changes the brigthness of attached secondary screens.
SUNRISE=`echo 6` # Change the value according to your region
SUNSET=`echo 18` # Change the value according to your region
dayBrightness=`echo 1` # Change the value according to your choice
nightBrightness=`echo 0.3` # Change the value according to your choice
TIME=`date | sed 's/:.*$//;s/^.* //;s/^0//'`
if [ $TIME -lt $SUNRISE ] || [ $TIME -gt $SUNSET ]; then
    desiredBrightness=$nightBrightness
    else desiredBrightness=$dayBrightness
fi
screenTest=`xrandr -q | grep " connected" | wc -l` # Check if there are any secondary screens
lastScreen=`xrandr -q | grep " connected" | awk 'END{print NR}'` # Number of screens. Screen 1 is Primary.
if [[ $screenTest > 1 ]]; then
	for Screen in 2 .. $lastScreen;do
      secondaryScreen=`xrandr -q | grep " connected" | awk -v thisScreen=$Screen 'NR==thisScreen' | cut -d' ' -f1`
		xrandr --output $secondaryScreen --brightness $desiredBrightness
		if [[ $lastScreen == 2 ]];then
			break
		fi
	done
fi

# End of script ####
