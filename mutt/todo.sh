#!/bin/bash

echo "Date: "`date +"%a, %d %b %Y %H:%M:%S %z"`"
From: TODO""
To: TODO""
Subject: $1""
MIME-Version: 1.0""
Content-Type: text/plain; charset=us-ascii""

$2" > ~/.mail/todo@fulso.me/inbox/new/$(date +"%s")."$BASHPID"_1."$(hostname)"

$HOME/.mutt/sync.sh "todo@fulso.me"
