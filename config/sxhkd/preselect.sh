#!/bin/bash
INFO=$(xwininfo -id $(bspc query -N -n focused))

WIDTH=$(echo "$INFO" | grep -oP 'Width: \d*' | grep -oP '\d*')
HEIGHT=$(echo "$INFO" | grep -oP 'Height: \d*' | grep -oP '\d*')

echo $WIDTH
echo $HEIGHT

if [[ -z $WIDTH || -z $HEIGHT ]]
then
  exit 0
fi

if [[ $WIDTH -gt $HEIGHT ]]
then
  bspc node -p east
else
  bspc node -p south
fi
