#!/bin/sh

exec >"${HOME}/.xsession.log" 2>&1

umask 0022

for file in "${HOME}/.sh/inc"/*.sh; do
  # shellcheck source=/dev/null
  . "${file}"
done

# Make Java Swing apps less ugly
_JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'; export _JAVA_OPTIONS

# Pretend to use Gnome
XDG_CURRENT_DESKTOP="GNOME"; export XDG_CURRENT_DESKTOP

# Qt theme
QT_QPA_PLATFORMTHEME="qgtk3"; export QT_QPA_PLATFORMTHEME

# X resources
if command -v xrdb >/dev/null 2>&1; then
  echo 'Loading X ressources...'
  xrdb -merge ~/.Xdefaults || echo 'Failed to load X ressources'
fi

# Set DPMS and screensaver, disable beep, autorepeat
if command -v xset >/dev/null 2>&1; then
  echo 'Configuring X...'
  xset dpms 300 600 900 s 300 60 -b r 66 r rate 400 30 || echo 'Failed to configure X'
fi

# Compose key
if command -v setxkbmap >/dev/null 2>&1; then
  echo 'Setting keymap...'
  setxkbmap -layout us -variant altgr-intl -option compose:menu,caps:escape || echo 'Failed to set keymap'
fi

# Pointer
if command -v xsetroot >/dev/null 2>&1; then
  echo 'Setting pointer...'
  xsetroot -cursor_name left_ptr || echo 'Failed to set pointer'
fi

# Configure Thinkpad Carbon X1's trackpad
TOUCHPAD_NAME="ELAN0672:00 04F3:3187 Touchpad"
if command -v xinput >/dev/null 2>&1 && xinput list --name-only "${TOUCHPAD_NAME}" >/dev/null 2>&1; then
  echo 'Configuring trackpad...'
  ## Vert + Horiz scrolling
  xinput set-prop "${TOUCHPAD_NAME}" "Synaptics Two-Finger Scrolling" 1 1
  ## Natural scrolling
  xinput set-prop "${TOUCHPAD_NAME}" "Synaptics Scrolling Distance" -75 -75
fi

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
dbus-update-activation-environment --systemd DISPLAY

# PolKit
if [ -x /usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 ]; then
  echo 'Launching PolicyKit agent...'
  /usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 || echo "Failed to launch PolicyKit agent" &
fi

# Gnome Keyring Daemon
if command -v gnome-keyring-daemon >/dev/null 2>&1; then
  echo 'Launching Gnome keyring daemon...'
  eval "$(gnome-keyring-daemon --start --components=ssh,secrets,pkcs11)" || echo "Failed to launch gnome-keyring-daemon"
fi

# light-locker
if command -v light-locker >/dev/null 2>&1; then
  echo 'Launching light-locker...'
  light-locker || echo 'Failed to launch light-locker' &
fi

# dunst
if command -v dunst >/dev/null 2>&1; then
  echo 'Launching dunst...'
  dunst -conf ~/.dunstrc || echo 'Failed to launch dunst' &
fi

# Bluetooth applet
if command -v blueman-applet >/dev/null 2>&1; then
  echo 'Launching Bluetooth applet...'
  blueman-applet || echo 'Failed to launch Bluetooth applet' &
fi

# Network Manager applet
if command -v nm-applet >/dev/null 2>&1; then
  echo 'Launching NetworkManager applet...'
  nm-applet || echo 'Failed to launch NetworkManager applet' &
fi

# PulseAudio applet
if command -v pasystray >/dev/null 2>&1; then
  echo 'Launching PulseAudio applet...'
  pasystray || echo 'Failed to launch PulseAudio applet' &
fi

# 1password
if command -v 1password >/dev/null 2>&1; then
  echo 'Launching 1password...'
  1password --silent || echo "Failed to launch 1password" &
fi

# Flameshot
if command -v flameshot >/dev/null 2>&1; then
  echo 'Launching flameshot...'
  flameshot || echo "Failed to launch flameshot" &
fi

# Local startup script
if [ -f "${HOME}/.xsession.local" ]; then
  . "${HOME}/.xsession.local"
fi

# i3
exec i3 || echo 'Failed to launch i3'

# vim:ft=sh:sw=2:
