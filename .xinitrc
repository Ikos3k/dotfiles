#!/bin/sh
#
# ~/.xinitrc
#

# Load Xresources
if [ -f "$HOME/.Xresources" ]; then
    xrdb -merge "$HOME/.Xresources"
fi

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# exec sway

export XDG_SESSION_TYPE=x11
exec i3
