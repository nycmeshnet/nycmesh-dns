NYC Mesh DNS
---

This repository manages the DNS zones for the `nycmesh.net` and `mesh.nycmesh.net` domains.

# mesh.nycmesh.net

Edit the mesh.zone file to add a record, please format appropriately and place under the proper heading. 

Please fork and make a pull request, don't push directly ( unless you have to )

## Requirements

Either:
* At least Knot 3.2 ( this is a new requirement for this repo, mainly because of ffi )
* Bind9, Debian preferred as it is scripted this way

## Use

There are serveral python scripts and shell scripts. The python scripts generate secondary files, such as reverse zones, and auto-generated records.  
`deploy.sh` is the original one for knot resolver  
`deploy-bind.sh` is the newer one as we move to bind. The name is different so older servers dont break as part of the change.

## Install

### Install Knot Pieces:
See Knot Resolver website.
Then, on debian for example. something like:
```
echo 'deb http://download.opensuse.org/repositories/home:/CZ-NIC:/knot-resolver-latest/Debian_9.0/ /' > /etc/apt/sources.list.d/home:CZ-NIC:knot-resolver-latest.list
wget -nv https://download.opensuse.org/repositories/home:CZ-NIC:knot-resolver-latest/Debian_9.0/Release.key -O Release.key
apt-key add - < Release.key
apt-get update
apt-get install knot-resolver knot

```

### Install Bind9:
Use NYC Mesh Ansible set up (no link yet), which will clone and setup this repo  
Alternately, just install bind9, clone this repo and run `./deploy-bind.sh`.

### Add to cron:
```
*/10 * * * *   root    cd /root/nycmesh-dns && /root/nycmesh-dns/deploy.sh 2>&1 > /dev/null
```
# nycmesh.net

Uses [lexfrei/namedotcom](https://registry.terraform.io/providers/lexfrei/namedotcom/latest/docs) to manage the DNS zone for the `nycmesh.net` domain.

See [nycmesh.net/README.md](./nycmesh.net/README.md) for more information.
