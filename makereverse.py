#!/usr/bin/env python

import re

domain = None
validreverse = ['10','59.167.199']
files = ['mesh.zone']
records = []
output = { r: [] for r in validreverse }

header = """$ORIGIN {}
$TTL 3600
@  SOA   nycmesh-713-dns-auth-3 hostmaster.nycmesh.net. ( 2024120100 1d 2h 4w 1h )
@  NS    nycmesh-713-dns-auth-3
@  NS    nycmesh-10-dns-auth-5
@  A     10.10.10.11
nycmesh-10-dns-auth-5 A 23.158.16.23
nycmesh-713-dns-auth-3 A 199.170.132.47
"""

def inaddrarpa(x):
  return '{}.in-addr.arpa.'.format(x)

def swapip(a):
  b = a.split('.')
  return '.'.join([b[3],b[2],b[1],b[0]])

def whichreversedomain(i):
    for r in validreverse:
        if re.search('.*\.' + r, i):
            return r
    return None

def chopname(n,z):
    return n[0:(0-len(z)-1)]
    
# Generate the PTRs for all A records
for f in files:
  with open('mesh.zone') as f:
    for l in f:
      j = l.strip().split()
      if len(j) == 3 and j[0] == ';' and j[1] == "$ORIGIN":
          domain = j[2]
      if len(j) == 3 and j[1] == "A":
        a = swapip(j[2])
        b = 'PTR'
        c = j[0] + '.' + domain
        wr = whichreversedomain(a)
        if wr is not None:
          a = chopname(a,wr)
          if wr == '59.167.199':
            c = c + 'nycmesh.net.'
          if not [ x for x in output[wr] if x[0] == a ]:
            output[wr].append([a,b,c])

# Output each record to the appropriate file
for k in output:
    fo = open(inaddrarpa(k) + 'zone', 'w')
    fo.write(header.format(inaddrarpa(k)))
    for i in output[k]:
        fo.write(' '.join(i) + '\n')
    fo.close()


