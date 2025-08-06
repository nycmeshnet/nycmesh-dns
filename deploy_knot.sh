#!/bin/bash

# Based on https://github.com/nycmeshnet/nycmesh-dns/blob/master/deploy.sh
# Modified for IaC managed servers

cd /root/nycmesh-dns
git pull

NEWCOMMIT=`git rev-parse HEAD`
OLDCOMMIT=`cat /var/lib/knot/commit`

if [ "$NEWCOMMIT" == "$OLDCOMMIT" ]
then
  exit 0
fi

python3 generate_nn.py
python3 makereverse.py
cp -f *.zone /var/lib/knot/zones
chown knot:knot /var/lib/knot/zones/*.zone
chmod 664 /var/lib/knot/zones/*.zone

systemctl restart knot
sleep 2

git rev-parse HEAD > /var/lib/knot/commit