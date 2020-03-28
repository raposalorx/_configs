#!/bin/bash

if [ "$(pgrep -f "mbsync -q sync-$1")" == "" ]
then
  { time mbsync -q sync-"$1" >/dev/null; } 2>&1 | grep -oP 'real\s*\K\d*m\d*(?=\.\d*s)' >> $HOME/.mutt/sync."$1".time
fi
