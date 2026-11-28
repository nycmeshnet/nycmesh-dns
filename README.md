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

Every zone that receives dynamic updates (the `_acme-challenge.*` TXT records written by certbot, plus `prox`, `nn`, `ha`, `doh`, ...) is **primary on one authoritative server** and mirrored to the other with NOTIFY/IXFR:

- **Primary** — `primary_auth_dns_ip` (`199.170.132.47`, `nycmesh-713-dns-auth-3`). This is the server the sub-zones are delegated to in `mesh.zone`, and the server certbot should send its TSIG updates to.
- **Secondary** — `secondary_auth_dns_ip` (`23.158.16.23`, `nycmesh-10-dns-auth-5`). Slave for those zones; it pulls changes via NOTIFY/IXFR and forwards DDNS updates it receives to the primary.

Both servers answer authoritatively for these zones, so a Let's Encrypt resolver can query either one and see the same records. For a standalone authoritative server (e.g. `dev_jon`), set `secondary_auth_dns_ip = ""` and no mirroring is configured.
