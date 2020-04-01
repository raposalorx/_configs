#!/bin/bash

# shellcheck source=/home/lorx/.style_vars
source "$HOME/.style_vars"

wid="$1"
class="$2"
instance="$3"
icqs="$4"

printf "%s\n$1\n$2\n$3\n$4\n\n" "$(date -u +'%Y-%m-%d#%H:%M:%S')" >> ~/.config/bspwm/.external.log

fwid="$(bspc query -N -n focused.automatic)"


if [ "$class" == "Quake" ]
then
  width="$(echo "$style_monitor_width 1.3 / p" | dc)"
  offset="$(echo "$style_monitor_width 2 / $width 2/ - p" | dc)"
  height="$(echo "$style_monitor_height 2/p" | dc)"
  echo "state=floating"
  echo "sticky=on"
  echo "focus=on"
  echo "border=off"
  echo "rectangle=${width}x${height}+${offset}+0"
fi

if [ "$class" == "Cheatsheet" ]
then
  width="$(echo "$style_monitor_width 2/p" | dc)"
  height="$(echo "$style_monitor_height 2/p" | dc)"
  offset="$(echo "$style_monitor_width 2/ $width 2/ - p" | dc)"
  yoffset="$(echo "$style_window_gap 2 * $style_bar_height + p" | dc)" # 32
  echo "state=floating"
  echo "sticky=on"
  echo "focus=on"
  echo "rectangle=${width}x${height}+${offset}+${yoffset}"
fi

if [ -n "$fwid" ]
then
  width="$(xwininfo -id "$fwid" | grep -oP 'Width: \d*' | grep -oP '\d*')"
  height="$(xwininfo -id "$fwid" | grep -oP 'Height: \d*' | grep -oP '\d*')"
  if [ "$height" -gt "$width" ]
  then
    echo "split_dir=south"
  else
    echo "split_dir=east"
  fi
  echo "split_ratio=0.5"
fi
