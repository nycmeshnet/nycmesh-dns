NYC Mesh DNS
---

This repository manages the DNS zones for the various NYC Mesh domains including `nycmesh.net` and `mesh.nycmesh.net` domains.

# mesh.nycmesh.net

Edit the [mesh.zone](./mesh.zone) file to add a record, please format appropriately and place under the proper heading. 

Please fork and make a pull request, don't push directly.

# Second Level Domains - nycmesh.net

Uses [lexfrei/namedotcom](https://registry.terraform.io/providers/lexfrei/namedotcom/latest/docs) to manage the DNS zones for the following domains.

1. [nycmesh.net](./sld/records.nycmesh.net.tf)
2. [nycmeshconnect.com](./sld/records.nycmeshconnect.com.tf)
3. [nycmeshconnect.net](./sld/records.nycmeshconnect.net.tf)
4. ~[themesh.nyc](./sld/records.themesh.nyc.tf)~ (defunct and deleted)
5. [nycmeshops.net](./sld/records.nycmeshops.net.tf)

# Hosting

The zones hosted inside the mesh are created and maintained via the terraform and ansible (IaC) found under [infra/](./infra/) and deployed via GitHub Actions as defined in [.github/workflows/deploy.yaml](./.github/workflows/deploy.yaml).

# Authoritative zone mirroring (ACME / DDNS)

Every zone that receives dynamic updates (the `_acme-challenge.*` TXT records written by certbot, plus `prox`, `nn`, `ha`, `doh`, ...) has **one primary authoritative server** and is mirrored to the rest with NOTIFY/IXFR:

- **Master** — `knot_master_mgt_ip` (`10.70.90.148`, `nycmesh-713-dns-auth-3`). This is the server the sub-zones are delegated to in `mesh.zone`. It is the only server that holds the authoritative copy of the dynamic records.
- **Secondaries** — `knot_secondary_mgt_ips` (`10.70.90.181`, `10.70.100.43`, `10.70.100.52`). Slaves for those zones; they pull changes via NOTIFY/IXFR and forward any DDNS update they receive to the master.

All servers answer authoritatively for these zones, so a Let's Encrypt resolver can query any of them and see the same records.

Mirroring is configured over the servers' **management IPs**, not the anycast DNS addresses. `199.170.132.47` and `23.158.16.23` are each answered by two VMs (one per site), so a `master`/`notify` remote pointing at those IPs splits the fleet into two islands that never see each other's updates. Management IPs are unique per VM and routable across the mesh; knot listens on them for transfers, and iptables already accepts port 53 to them from `10.70.0.0/16`.

Knot's automatic ACL is not enough here: the peer `remote` has no TSIG key, so an explicit `acl-knot-peer` rule (`transfer`, `notify`, `update` from the peer management IP) is required, otherwise NOTIFY and XFR are rejected with `NOTAUTH`. Forwarded DDNS updates are not re-signed, which is why the peer rule also allows `update`.

For a standalone authoritative server (e.g. `dev_jon`), leave `knot_secondary_mgt_ips = []` and no mirroring is configured.

`deploy_knot.sh` copies the zone files from git on every deploy, which resets the mirrored zones back to the serial in git. It then runs `knotc zone-refresh` on the secondaries so they immediately IXFR the current data from the master instead of waiting for the SOA refresh interval (1 day).
