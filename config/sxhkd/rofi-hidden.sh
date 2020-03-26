#!/bin/bash
WINDOWS=($(bspc query -N -n .window.hidden))
SELECTIONS="$(for i in ${!WINDOWS[@]}
do
  printf '%s %s\n' $i "$(xtitle ${WINDOWS[i]})"
done)"

INDEX=$(echo "$SELECTIONS" | rofi -dmenu)
NODE=${WINDOWS[${SELECTIONS%% *}]}
bspc node "$NODE" -g hidden=off
bspc node "$NODE" -f
