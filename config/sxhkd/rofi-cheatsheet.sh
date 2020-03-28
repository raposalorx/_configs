#!/bin/bash

# Pull markdown files from cheatsheets folder
GEN=$(find "$HOME/.config/cheatsheets/" -maxdepth 1 -type f -name '*.md' -printf '* %p\n')

# IFS for this statement only
# Configs that are commented properly, append the markdown files
IFS=$'\n' SHEETS=($(\
printf "# $HOME/.config/sxhkd/sxhkdrc\n" &&\
printf "$GEN" \
))

# Create a dmenu menu with an index from sheets
MENU="$(for i in ${!SHEETS[@]}
do
  PATH=${SHEETS[i]##* } # Remove delimiter and just leave path
  FILE=${PATH##*/} # Remove path and just leave file
  TITLE=${FILE%%.*} # Remove extension
  printf '%s %s\n' $i $TITLE
done
)"

INDEX=$(echo "$MENU" | rofi -i -only-match -p "Cheatsheet" -dmenu)

# Get just the index from dmenu, use it to get the sheet
SHEET=${SHEETS[${INDEX%% *}]}

# echo ${INDEX##* } # remove prefix by space
# echo ${INDEX%% *} # remove suffix by space

~/.config/sxhkd/cheatsheet.sh "${SHEET##* }" "${SHEET%% *}"
