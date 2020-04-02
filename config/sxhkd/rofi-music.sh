#!/bin/bash

pick=$(printf 'mpd\nmopidy' | rofi -dmenu)
musicsource "$pick"
