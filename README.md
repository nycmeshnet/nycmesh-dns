# NYC Mesh DNS

Edit the mesh.zone file to add a record, please format appropriately and place under the proper heading. 

Please fork and make a pull request, don't push directly ( unless you have to )

# REQUIREMENTS

* At least Knot 3.2 ( this is a new requirement for this repo, mainly because of ffi )

# Install

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

### Add to cron:
```
*/10 * * * *   root    cd /root/nycmesh-dns && /root/nycmesh-dns/deploy.sh 2>&1 > /dev/null
```


