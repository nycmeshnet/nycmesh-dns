#!/bin/bash

# Based on https://github.com/nycmeshnet/nycmesh-dns/blob/master/deploy.sh
# Modified for IaC managed servers

cd /root/nycmesh-dns
git pull

NEWCOMMIT=`git rev-parse HEAD`
OLDCOMMIT=`cat /var/lib/knot/commit`

if [ "$NEWCOMMIT" == "$OLDCOMMIT" ]; then
  exit 0
fi

python3 generate_nn.py
python3 makereverse.py

# Mirrored zones have a single master and are copied to the secondaries with
# NOTIFY/IXFR. Only seed them where they are primary, otherwise a deploy would
# roll the serial back and drop the DDNS records the master already has.
mirrored_zones=$(awk '/^  - domain:/ { z=$3 } /^[[:space:]]+file:/ { f=$2 } /^[[:space:]]+master: knot-master/ { print f }' /etc/knot/knot.conf)
is_secondary=$([ -n "$mirrored_zones" ] && echo 1 || echo 0)

for zone in *.zone; do
  if [ "$is_secondary" == 1 ] && echo "$mirrored_zones" | grep -qx "$zone"; then
    continue
  fi
  cp -f "$zone" /var/lib/knot/zones
done

chown knot:knot /var/lib/knot/zones/*.zone
chmod 664 /var/lib/knot/zones/*.zone

systemctl restart knot
sleep 2

git rev-parse HEAD > /var/lib/knot/commit

# Pull the current copy of the mirrored zones from the master right away instead
# of waiting for the SOA refresh interval (1 day).
if [ "$is_secondary" == 1 ]; then
  knotc zone-refresh $(awk '/^  - domain:/ { z=$3 } /^[[:space:]]+master: knot-master/ { print z }' /etc/knot/knot.conf)
fi
