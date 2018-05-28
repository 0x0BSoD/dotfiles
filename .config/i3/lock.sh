#!/bin/bash
[[ -f ~/.config/i3/lock.png ]] && convert ~/Pictures/lockscr.jpg ~/.config/i3/lock.png -gravity center -composite -matte /tmp/screen.png
i3lock -t -e -f -c 000000 -i /tmp/screen.png
sleep 60 && pgrep i3lock && xset dpms force off
