#!/bin/bash

# Based on https://github.com/nycmeshnet/nycmesh-dns/blob/master/deploy.sh
# Modified for gordian-knot

cd /root/nycmesh-dns
git pull

NEWCOMMIT=`git rev-parse HEAD`
OLDCOMMIT=`cat /var/lib/knot/commit`

if [ "$NEWCOMMIT" == "$OLDCOMMIT" ]
then
  exit 0
fi

python3 makereverse.py
#cp knot.conf /etc/knot/knot.conf
cp -f *.zone /var/lib/knot/zones

systemctl restart knot
sleep 2

git rev-parse HEAD > /var/lib/knot/commit