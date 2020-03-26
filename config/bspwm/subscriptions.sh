#!/bin/bash

bspc subscribe node_focus | \
  while read -r event monitor desktop node; do 
    class="$(xprop -id $node | grep -P '^WM_CLASS' | grep -oP '"\K\S*(?="$)')"
    case $class in
      "Firefox")
        bspc config focused_border_color '#ebdbb2'
        ;;
      *) # default condition
        bspc config focused_border_color '#ebdbb2'
        ;;
    esac
  done &
