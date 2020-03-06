#!/bin/bash

# Designed firstly for nycmesh-375p-dns1, need to make more portable for other nodes

cd /root/nycmesh-dns
git pull

NEWCOMMIT=`git rev-parse HEAD`
OLDCOMMIT=`cat /root/nycmesh-dns.commit`

if [ "$NEWCOMMIT" == "$OLDCOMMIT" ]
then
  exit 0
fi

cp mesh.zone mesh.zone.original
python nodensrecords.py >> mesh.zone

python makereverse.py
cp -f *.zone /etc/bind/

mv mesh.zone.original mesh.zone

systemctl restart bind9

git rev-parse HEAD > /root/nycmesh-dns.commit
