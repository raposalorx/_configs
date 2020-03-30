#!/bin/bash

wid="$1"
class="$2"
instance="$3"
icqs="$4"

printf "%s\n$1\n$2\n$3\n$4\n\n" $(date -u +"%Y-%m-%d#%H:%M:%S") >> ~/.config/bspwm/.external.log

fwid="$(bspc query -N -n focused.automatic)"


if [ "$class" == "Quake" ]
then
  mwidth="$(xrandr | grep -Po 'primary\s\K\d+(?=x)')"
  width="$(echo $mwidth 1.5/p | dc)"
  offset="$(echo $mwidth 2/ $width 2/ - p | dc)"
  echo "state=floating"
  echo "sticky=on"
  echo "focus=on"
  echo "border=off"
  echo "rectangle=${width}x400+${offset}+0"
fi

if [ "$class" == "Cheatsheet" ]
then
  mwidth="$(xrandr | grep -Po 'primary\s\K\d+(?=x)')"
  width="$(echo $mwidth 2/p | dc)"
  offset="$(echo $mwidth 2/ $width 2/ - p | dc)"
  echo "state=floating"
  echo "sticky=on"
  echo "focus=on"
  echo "rectangle=${width}x400+${offset}+32"
fi

if [ -n "$fwid" ]
then
  width="$(xwininfo -id $fwid | grep -oP 'Width: \d*' | grep -oP '\d*')"
  height="$(xwininfo -id $fwid | grep -oP 'Height: \d*' | grep -oP '\d*')"
  if [ $height -gt $width ]
  then
    echo "split_dir=south"
  else
    echo "split_dir=east"
  fi
  echo "split_ratio=0.5"
fi
