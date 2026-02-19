#!/usr/bin/env bash
pkill -u $(id -u) -f gnome-keyring-daemon 2>/dev/null

if [ -z "$DBUS_SESSION_BUS_ADDRESS" ];
then
    eval $(dbus-launch --sh-syntax)
fi

kwalletd6 &

#export $(dbus-send --session --dest=org.kde.kwalletd6 --type=method_call --print-reply / modules/kwalletd6 org.kde.KWallet.isEnabled | grep true >/dev/null && echo "SECRET_SERVICE=/usr/bin/kwalletd6)

