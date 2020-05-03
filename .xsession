#!/bin/sh

exec >"${HOME}/.xsession.log" 2>&1

umask 0022

for file in "${HOME}/.sh/inc"/*.sh; do
  # shellcheck source=/dev/null
  . "${file}"
done

# OpenOffice.org look
OOO_FORCE_DESKTOP=gnome
export OOO_FORCE_DESKTOP

XDG_CURRENT_DESKTOP=GNOME
export XDG_CURRENT_DESKTOP

# Make Java Swing apps less ugly
_JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
export _JAVA_OPTIONS

# GnuPG
if command -v gpg-agent >/dev/null 2>&1; then
  echo 'Launching GPG agent...'
  eval $(gpg-agent --daemon) || echo "Failed to launch GPG agent"
fi

# D-Bus
if [ -z "${DBUS_SESSION_BUS_ADDRESS}" ]; then
  if command -v dbus-launch >/dev/null 2>&1; then
    echo 'Launching D-BUS per-session daemon...'
    eval $(dbus-launch --sh-syntax --exit-with-session) || echo "Failed to launch D-Bus session daemon"
    echo "D-BUS per-session daemon address: ${DBUS_SESSION_BUS_ADDRESS}"
  fi
fi

# X ressources
if command -v xrdb >/dev/null 2>&1; then
  echo 'Loading X ressources...'
  xrdb -merge ~/.Xdefaults || echo 'Failed to load X ressources'
fi

# set DPMS and screensaver, disable beep, autorepeat
if command -v xset >/dev/null 2>&1; then
  echo 'Configuring X...'
  xset dpms 300 600 900 s 300 600 -b r 66 r rate 400 30 || echo 'Failed to configure X'
fi

# Compose key
if command -v setxkbmap >/dev/null 2>&1; then
  echo 'Setting keymap...'
  setxkbmap -layout us -variant altgr-intl -option compose:menu,caps:escape || echo 'Failed to set keymap'
fi

# pointer
if command -v xsetroot >/dev/null 2>&1; then
  echo 'Setting pointer...'
  xsetroot -cursor_name left_ptr || echo 'Failed to set pointer'
fi

# xautolock
if command -v xss-lock >/dev/null 2>&1; then
  echo 'Launching xss-lock...'
  xset s 290 10
  xss-lock --transfer-sleep-lock --notifier "notify-send -u normal -t 10000 -a xss-lock 'Autolocking session in 10 seconds...'" "${HOME}/.i3/lock" || echo 'Failed to launch xss-lock' &
# light-locker
elif command -v light-locker >/dev/null 2>&1; then
  echo 'Launching light-locker...'
  light-locker || echo 'Failed to launch light-locker' &
# xscreensaver
elif command -v xscreensaver >/dev/null 2>&1; then
  echo 'Launching xscreensaver...'
  xscreensaver -nosplash -no-capture-stderr || echo 'Failed to launch xscreensaver' &
fi

# dunst
if command -v dunst >/dev/null 2>&1; then
  echo 'Launching dunst...'
  dunst -conf ~/.dunstrc || echo 'Failed to launch dunst' &
fi

if [ -f "${HOME}/.xsession.local" ]; then
  . "${HOME}/.xsession.local"
fi

# i3
exec i3 || echo 'Failed to launch i3'

# vim:ft=sh:sw=2:
