#!/bin/bash
#
# This script toggles the extended monitor outputs if something is connected
#

# your notebook monitor
DEFAULT_OUTPUT=$(xrandr |awk '/eDP-1/ {print $1}')
# all connected outputs
OUTPUTS=$(xrandr |awk '/ connected / {print $1}'|sed '/'$DEFAULT_OUTPUT'/d')
# get info from xrandr
XRANDR=`xrandr`

EXECUTE=""

for CURRENT in $OUTPUTS
do
	if [[ $XRANDR == *$CURRENT\ connected\ \(* ]] # is disabled
    then
    	EXECUTE+="--output $CURRENT --auto --right-of $DEFAULT_OUTPUT "
    else
      EXECUTE+="--output $CURRENT --off "
  fi
done

echo -e $EXECUTE
xrandr --output $DEFAULT_OUTPUT --auto --primary $EXECUTE
~/suckless/scripts/wp-change.sh
