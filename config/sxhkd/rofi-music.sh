#!/bin/bash

pick=$(printf 'mpd\nmopidy' | rofi -dmenu)
~/.bin/musicsource "$pick"
