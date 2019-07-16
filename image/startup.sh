#!/bin/bash

mkdir -p /var/run/sshd
mkdir -p /var/run/dbus
service dbus restart

chown -R root:root /root

if [ -n "$VNC_PASSWORD" ]; then
    echo -n "$VNC_PASSWORD" > /.password1
    x11vnc -storepasswd $(cat /.password1) /.password2
    chmod 400 /.password*
    sed -i 's/^command=x11vnc.*/& -rfbauth \/.password2/' /etc/supervisor/conf.d/supervisord.conf
    export VNC_PASSWORD=
fi

/usr/bin/supervisord -n
