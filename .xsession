#!/bin/sh

exec >~/.xsession.log 2>&1

. ~/.profile

# OpenOffice.org look
OOO_FORCE_DESKTOP=gnome
export OOO_FORCE_DESKTOP

# keychain (ssh-agent and gpg-agent)
if which keychain >/dev/null; then
  echo 'Launching keychain...'
  keychain --quiet --nogui || echo 'Failed to launch keychain'
  [ -f ~/.keychain/`hostname`-sh ]     && . ~/.keychain/`hostname`-sh
  [ -f ~/.keychain/`hostname`-sh-gpg ] && . ~/.keychain/`hostname`-sh-gpg
fi

# D-Bus
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
  if which dbus-launch >/dev/null; then
    echo 'Launching D-BUS per-session daemon...'
    eval `dbus-launch --sh-syntax --exit-with-session` || echo "Failed to launch D-Bus session daemon"
    echo "D-BUS per-session daemon address: ${DBUS_SESSION_BUS_ADDRESS}"
  fi
fi

# xrandr
if which xrandr >/dev/null; then
  echo 'Configuring screens...'
  if [ `hostname -s` = 'alderaan' ]; then
    # xrandr --output DVI-0 --auto --output HDMI-0 --auto --right-of DVI-0 || echo 'Failed to configure screens with xrandr'
    xrandr --output DVI-I-2 --auto --output DVI-I-3 --off
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
  if [ -d /usr/local/lib/X11/fonts/terminus-font ]; then
      xset +fp /usr/local/lib/X11/fonts/terminus-font:unscaled || echo 'Failed to add terminus to X font path'
  fi
  if [ -d /usr/local/lib/X11/fonts/dina ]; then
      xset +fp /usr/local/lib/X11/fonts/dina || echo 'Failed to add dina to X font path'
  fi
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

# xbindkeys
if which xbindkeys >/dev/null; then
  echo 'Launching xbindkeys...'
  LC_ALL=C xbindkeys || echo 'Failed to launch xbindkeys'
fi

# xscreensaver
if which xscreensaver >/dev/null; then
  echo 'Launching xscreensaver...'
  xscreensaver -nosplash -no-capture-stderr || echo 'Failed to launch xscreensaver' &
fi

# urxvtd
# if which urxvtd >/dev/null; then
#   echo 'Launching urxvt daemon...'
#   urxvtd -f -o -q || echo 'Failed to launch urvxt daemon'
# fi

# composite
# if which xcompmgr >/dev/null; then
#   echo 'Launching composite manager...'
#   xcompmgr -c -C -o0.2 -t1 -l1 -r2 >/dev/null 2>&1 || echo 'Failed to launch composite manager' &
# fi

# launch WM, launch the first found, by order of preference
for wm in awesome wmii fluxbox e16 enlightenment fvwm; do
  if which $wm >/dev/null; then
    exec $wm >>~/.xsession.log 2>&1
  fi
  echo 'Failed to launch any prefered WM'
done

# vim:ft=sh:sw=2:
