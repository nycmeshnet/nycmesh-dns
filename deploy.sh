#!/bin/bash

# Designed firstly for nycmesh-375p-dns1, need to make more portable for other nodes

cd /root/nycmesh-dns
python makereverse.py
cp kresd.conf /etc/knot-resolver/kresd.conf
cp knot.conf /etc/knot/knot.conf
cp -f *.zone /var/lib/knot/zones

systemctl restart knot
systemctl stop kresd.service
sleep 2
systemctl start kresd.socket
systemctl start kresd.socket
