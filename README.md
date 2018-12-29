# NYC Mesh DNS

Edit the mesh.zone file to add a record, please format appropriately and place under the proper heading. 

Please fork and make a pull request, don't push directly ( unless you have to )

To deploy:
Add to cron:
```
*/10 * * * *   root    cd /root/nycmesh-dns && /root/nycmesh-dns/deploy.sh 2>&1 > /dev/null
```

# REQUIREMENTS

* At least Knot 3.2 ( this is a new requirement for this repo, mainly because of ffi )

