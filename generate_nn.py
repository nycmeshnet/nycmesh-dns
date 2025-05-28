#!/usr/bin/env python

header = """$TTL 3600
@  SOA   nycmesh-713-dns-auth-3 hostmaster.nycmesh.net. ( 2025052100 1d 2h 4w 1h )
@  NS    nycmesh-713-dns-auth-3
@  NS    nycmesh-10-dns-auth-5

nycmesh-10-dns-auth-5 A 23.158.16.23
nycmesh-713-dns-auth-3 A 199.170.132.47
nycmesh-713-jon-dns-auth-1 A 199.170.132.48

"""

def get_nn_ip(nn_s):
    third_octet = 0 if len(nn_s) <3 else nn_s[0:len(nn_s)-2]
    fourth_octet = nn_s[len(nn_s)-2:] if len(nn_s) <3 else str(int(nn_s[-2:]))
    return f"10.69.{third_octet}.{fourth_octet}"

with open("nn.zone", "w") as fd:
    fd.write(header)
    for nn in range(1, 8001):
        fd.write(f"nn{nn} A {get_nn_ip(str(nn))}\n")
        fd.write(f"{nn} CNAME nn{nn}\n")
