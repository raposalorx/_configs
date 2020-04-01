#!/bin/bash

# :a;N;$!ba; is black-magick, just let it happen
fs=$(find "$HOME"/.backs -maxdepth 1 -type d \( -name '.backs' -o ! -name '.*' \) -printf '%f\n' | rofi -multi-select -no-auto-select -dmenu | sed -e 's/.backs/./' -e ':a;N;$!ba;s/\n/ /g')

# An empty string is still an argument. Likewise, don't escape the $fs as you want the spaces to split out
if [ "$fs" == "" ]
then
  "$HOME"/.bin/backgrounds >/dev/null &
else
  # shellcheck disable=2086
  "$HOME"/.bin/backgrounds $fs >/dev/null &
fi
