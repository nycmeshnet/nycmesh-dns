#!/bin/bash

# Designed firstly for nycmesh-375p-dns1, need to make more portable for other nodes

cd /root/nycmesh-dns
git pull

NEWCOMMIT=`git rev-parse HEAD`
OLDCOMMIT=`cat /var/lib/knot/commit`

if [ "$NEWCOMMIT" == "$OLDCOMMIT" ]
then
  exit 0
fi

python makereverse.py
cp kresd.conf /etc/knot-resolver/kresd.conf
cp knot.conf /etc/knot/knot.conf
cp -f *.zone /var/lib/knot/zones

systemctl restart knot
systemctl stop kresd.service
sleep 2
systemctl start kresd.socket
systemctl start kresd.socket
systemctl restart system-kresd.slice

git rev-parse HEAD > /var/lib/knot/commit
