#!/usr/bin/env python

import re

domain = None
validreverse = ['10','59.167.199']
files = ['mesh.zone']
records = []
output = { r: [] for r in validreverse }

header = """$ORIGIN {}
$TTL 3600
@  SOA   10.10.10.11. noc.nycmesh.net. ( 2018042700 1d 2h 4w 1h )
@  NS    ns
@  A     10.10.10.11
ns A     10.10.10.11
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


