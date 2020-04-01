#!/bin/bash

# shellcheck source=/home/lorx/.style_vars
source "$HOME/.style_vars"

bspc monitor -d {1..22}

bspc config border_width "$style_border_width"
bspc config window_gap "$style_window_gap"

bspc config initial_polarity second_child
bspc config split_ratio          0.50
bspc config borderless_monocle   true
bspc config gapless_monocle      false
bspc config focus_follows_pointer false
bspc config focus_by_distance true

bspc config normal_border_color "$style_grey"
bspc config focused_border_color "$style_fg"
bspc config presel_border_color "$style_yellow"
bspc config normal_sticky_border_color "$style_bg2"
bspc config focused_sticky_border_color "$style_blue_b"
bspc config urgent_border_color "$style_red_b"
