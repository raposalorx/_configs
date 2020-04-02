#!/bin/bash

growisofs -dvd-compat -Z /dev/sr0="$1"
