#!/bin/sh

exec >"$HOME/.xsession.log" 2>&1

ENV="$HOME/.shrc"
export ENV
. $ENV

# OpenOffice.org look
OOO_FORCE_DESKTOP=gnome
export OOO_FORCE_DESKTOP

XDG_CURRENT_DESKTOP=GNOME
export XDG_CURRENT_DESKTOP

# GnuPG
if which gpg-agent >/dev/null; then
  echo 'Launching GPG agent...'
  eval `gpg-agent --daemon` || echo "Failed to launch GPG agent"
fi

# D-Bus
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
  if which dbus-launch >/dev/null; then
    echo 'Launching D-BUS per-session daemon...'
    eval `dbus-launch --sh-syntax --exit-with-session` || echo "Failed to launch D-Bus session daemon"
    echo "D-BUS per-session daemon address: ${DBUS_SESSION_BUS_ADDRESS}"
  fi
fi

# X ressources
if which xrdb >/dev/null; then
  echo 'Loading X ressources...'
  xrdb -merge ~/.Xdefaults || echo 'Failed to load X ressources'
fi

# set DPMS and screensaver, disable beep, autorepeat
if which xset >/dev/null; then
  echo 'Configuring X...'
  xset dpms 600 1200 4200 s 300 600 -b r 66 r rate 400 30 || echo 'Failed to configure X'
fi

# Compose key
if which setxkbmap >/dev/null; then
  echo 'Setting keymap...'
  setxkbmap -layout us -variant altgr-intl -option compose:menu,caps:backspace || echo 'Failed to set keymap'
fi

# pointer
if which xsetroot >/dev/null; then
  echo 'Setting pointer...'
  xsetroot -cursor_name left_ptr || echo 'Failed to set pointer'
fi

# light-locker
if which light-locker >/dev/null; then
  echo 'Launching light-locker...'
  light-locker || echo 'Failed to launch light-locker' &
# xscreensaver
elif which xscreensaver >/dev/null; then
  echo 'Launching xscreensaver...'
  xscreensaver -nosplash -no-capture-stderr || echo 'Failed to launch xscreensaver' &
fi

# dunst
if which dunst >/dev/null; then
  echo 'Launching dunst...'
  dunst -conf ~/.dunstrc || echo 'Failed to launch dunst' &
fi

if [ -f ~/.xsession.local ]; then
  . ~/.xsession.local
fi

# launch WM, launch the first found, by order of preference
for wm in i3 awesome wmii fluxbox e16 enlightenment fvwm; do
  if which $wm >/dev/null; then
    exec $wm >>~/.xsession.log 2>&1
  fi
  echo 'Failed to launch any prefered WM'
done

# vim:ft=sh:sw=2:
