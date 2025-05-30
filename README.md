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
4. [themesh.nyc](./sld/records.themesh.nyc.tf)

# Hosting

The zones hosted inside the mesh are created and maintained via the terraform and ansible (IaC) found under [infra/](./infra/) and deployed via GitHub Actions as defined in [.github/workflows/deploy.yaml](./.github/workflows/deploy.yaml).
