#!/bin/bash

IPDATEI="/tmp/ipold.txt"

UPDATE=false
IPNOW=$(/usr/bin/curl -k https://checkipv4.dedyn.io)

if [ ! -f $IPDATEI ] ; then
    UPDATE=true
else
    IPOLD=$(cat $IPDATEI)
    if [ "$IPOLD" != "$IPNOW" ] ; then
        UPDATE=true;
    fi
fi

if $UPDATE ; then
    echo $IPNOW > $IPDATEI

	curl  "https://update.dedyn.io/update?username=clwmedia.dedyn.io&password=YOURPASSWORD"
fi