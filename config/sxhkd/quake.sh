#!/bin/bash

node=""
for i in $(bspc query -N); do
  exists=$(xprop -id "$i" 2> /dev/null | grep -oP '\"Quake\"$')
  if [ ! "$exists" == "" ]; then
    node="$i"
    break
  fi
done

if [ ! "$node" == "" ]; then
  bspc node "$node" -g hidden
  bspc node "$node" -f
else
  termite --class Quake &
fi
