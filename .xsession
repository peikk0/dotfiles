#!/bin/sh

exec >"${HOME}/.xsession.log" 2>&1

ENV="${HOME}/.shrc"
export ENV
. ${ENV}

# OpenOffice.org look
OOO_FORCE_DESKTOP=gnome
export OOO_FORCE_DESKTOP

XDG_CURRENT_DESKTOP=GNOME
export XDG_CURRENT_DESKTOP

# Make Java Swing apps less ugly
_JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
export _JAVA_OPTIONS

# GnuPG
if type gpg-agent >/dev/null; then
  echo 'Launching GPG agent...'
  eval `gpg-agent --daemon` || echo "Failed to launch GPG agent"
fi

# D-Bus
if [ -z "${DBUS_SESSION_BUS_ADDRESS}" ]; then
  if type dbus-launch >/dev/null; then
    echo 'Launching D-BUS per-session daemon...'
    eval `dbus-launch --sh-syntax --exit-with-session` || echo "Failed to launch D-Bus session daemon"
    echo "D-BUS per-session daemon address: ${DBUS_SESSION_BUS_ADDRESS}"
  fi
fi

# X ressources
if type xrdb >/dev/null; then
  echo 'Loading X ressources...'
  xrdb -merge ~/.Xdefaults || echo 'Failed to load X ressources'
fi

# set DPMS and screensaver, disable beep, autorepeat
if type xset >/dev/null; then
  echo 'Configuring X...'
  xset dpms 600 1200 4200 s 300 600 -b r 66 r rate 400 30 || echo 'Failed to configure X'
fi

# Compose key
if type setxkbmap >/dev/null; then
  echo 'Setting keymap...'
  setxkbmap -layout us -variant altgr-intl -option compose:menu,caps:escape || echo 'Failed to set keymap'
fi

# pointer
if type xsetroot >/dev/null; then
  echo 'Setting pointer...'
  xsetroot -cursor_name left_ptr || echo 'Failed to set pointer'
fi

# xautolock
if type xautolock >/dev/null; then
  echo 'Launching xautolock...'
  xautolock -detectsleep -time 5 -notify 10 -notifier "notify-send -u normal -t 10000 -a xautolock 'Autolocking session in 10 seconds...'" -locker "${HOME}/.i3/lock" || echo 'Failed to launch xautolock' &
# light-locker
elif type light-locker >/dev/null; then
  echo 'Launching light-locker...'
  light-locker || echo 'Failed to launch light-locker' &
# xscreensaver
elif type xscreensaver >/dev/null; then
  echo 'Launching xscreensaver...'
  xscreensaver -nosplash -no-capture-stderr || echo 'Failed to launch xscreensaver' &
fi

# dunst
if type dunst >/dev/null; then
  echo 'Launching dunst...'
  dunst -conf ~/.dunstrc || echo 'Failed to launch dunst' &
fi

if [ -f ~/.xsession.local ]; then
  . ~/.xsession.local
fi

# i3
exec i3 || echo 'Failed to launch i3'

# vim:ft=sh:sw=2:
