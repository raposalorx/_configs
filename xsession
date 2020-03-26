setxkbmap dvorak
xmodmap .xmodmaprc

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

xset -dpms
xset s off
xset +fp /usr/share/fonts/TTF
xset fp rehash

xinput set-int-prop "SynPS/2 Synaptics TouchPad" "Synaptics Palm Detection" 8 1
xinput set-int-prop "SynPS/2 Synaptics TouchPad" "Synaptics Palm Dimensions" 32 10 200
xinput set-int-prop "SynPS/2 Synaptics TouchPad" "Synaptics Tap Action" 8 0 0 0 0 0 0 0

bspwm &
wmpid=$!

sleep 30

#redshift -m randr -l 51.0486:'-114.0708'

wait $wmpid
