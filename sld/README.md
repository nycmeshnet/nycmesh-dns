# NYCMesh Second Level Domains

1. [nycmesh.net](./records.nycmesh.net.tf)
2. [nycmeshconnect.com](./records.nycmeshconnect.com.tf)
3. [nycmeshconnect.net](./records.nycmeshconnect.net.tf)
4. [themesh.nyc](./records.themesh.nyc.tf)

## Add DNS Record(s)

1. Fork the repository if needed.
2. Create a new branch.
3. Add a new entry to the corresponding file `records.<DOMAIN>.tf`. Consult the [lexfrei/namedotcom documentation](https://registry.terraform.io/providers/lexfrei/namedotcom/latest/docs) as needed. The example below creates an `A` record pointed at `1.1.1.2`.
4. Open a [pull request](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request) to `main`.

```
resource "namedotcom_record" "record_test" {
    domain_name = "nycmesh.net"
    host = "test"
    record_type = "A"
    answer = "1.1.1.2"
}
```

## Setup

To use this repository as a template for managing other existing DNS zones hosted by [name.com](https://name.com), see [setup/README.md](./setup/README.md).
