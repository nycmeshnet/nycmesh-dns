#!/usr/bin/env python

def nodetoiprange(nn):
    return (
            10,
            96 + (nn>>10),
            (nn>>2)&255,
            ((nn&3)<<6)
            )

for nn in range(8192):
    cidr = nodetoiprange(nn)
    rtrip = "{}.{}.{}.{}".format(cidr[0], cidr[1], cidr[2], cidr[3]+1)
    print "nycmesh-{}-rtr A {}".format(nn, rtrip)
    print "n{} NS {}".format(nn, "nycmesh-{}-rtr".format(nn))
