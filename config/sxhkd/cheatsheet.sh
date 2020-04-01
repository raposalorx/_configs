#!/bin/bash

if [[ $2 == "*" ]]; then
  cat "$1" > /tmp/cheatsheet
else
  pcre2grep -M '((^'"$2"' .*$\n)+^[^'"$2"'\s]|^#.*{{{)' < "$1" > /tmp/cheatsheet
  sed -i -e 's/^'"$2"'\(.*\){{{/ # \1/' -e 's/^'"$2"'/##/' /tmp/cheatsheet
fi
termite --class Cheatsheet -e \
  "/bin/zsh -ic 'glow -w 80 -s ~/.config/glow/cheatsheet.json -p /tmp/cheatsheet'"
