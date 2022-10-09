# NYCMESH-DNS

### Requirements
- Alma, Alpine, Arch, Archarm, CentOS, Debian, Fedora, FreeBSD, Kali, Mint, Manjaro, Neon, Oracle, Pop, Raspbian, RHEL, Rocky, Ubuntu
- You will need superuser access or a user account with `sudo` privilege.

### Installation
Lets first use `curl` and save the file in `/usr/local/bin/`
```
curl https://raw.githubusercontent.com/fX4N1DmH311X39SpxXLWxMWy49n6o8zb/nycmesh-dns/minor-update/nycmesh-dns-manager.sh --create-dirs -o /usr/local/bin/nycmesh-dns-manager.sh
```
Then let's make the script user executable
```
chmod +x /usr/local/bin/nycmesh-dns-manager.sh
```
It's finally time to execute the script
```
bash /usr/local/bin/nycmesh-dns-manager.sh
```

### Compatibility with Linux Distro
| OS              | i386               | amd64              | armhf              | arm64              |
| --------------  | ------------------ | ------------------ | ------------------ | ------------------ |
| Ubuntu          |:heavy_check_mark:  |:heavy_check_mark:  |:heavy_check_mark:  |:heavy_check_mark:  |
| Debian          |:heavy_check_mark:  |:heavy_check_mark:  |:heavy_check_mark:  |:heavy_check_mark:  |
| CentOS          |:heavy_check_mark:  |:heavy_check_mark:  |:heavy_check_mark:  |:heavy_check_mark:  |
| Fedora          |:x:                 |:x:                 |:x:                 |:x:                 |
| RedHat          |:x:                 |:x:                 |:x:                 |:x:                 |
| Kali            |:x:                 |:x:                 |:x:                 |:x:                 |
| Arch            |:heavy_check_mark:  |:heavy_check_mark:  |:heavy_check_mark:  |:heavy_check_mark:  |
| Raspbian        |:heavy_check_mark:  |:heavy_check_mark:  |:heavy_check_mark:  |:heavy_check_mark:  |
| PopOS           |:heavy_check_mark:  |:heavy_check_mark:  |:heavy_check_mark:  |:heavy_check_mark:  |
| Manjaro         |:heavy_check_mark:  |:heavy_check_mark:  |:heavy_check_mark:  |:heavy_check_mark:  |
| Mint            |:heavy_check_mark:  |:heavy_check_mark:  |:heavy_check_mark:  |:heavy_check_mark:  |
| Alma            |:heavy_check_mark:  |:heavy_check_mark:  |:heavy_check_mark:  |:heavy_check_mark:  |
| Alpine          |:heavy_check_mark:  |:heavy_check_mark:  |:heavy_check_mark:  |:heavy_check_mark:  |
| FreeBSD         |:heavy_check_mark:  |:heavy_check_mark:  |:heavy_check_mark:  |:heavy_check_mark:  |
| Neon            |:heavy_check_mark:  |:heavy_check_mark:  |:heavy_check_mark:  |:heavy_check_mark:  |
| Rocky           |:heavy_check_mark:  |:heavy_check_mark:  |:heavy_check_mark:  |:heavy_check_mark:  |
| Oracle          |:heavy_check_mark:  |:heavy_check_mark:  |:heavy_check_mark:  |:heavy_check_mark:  |

### Compatibility with Virtualization
| Virtualization  | Supported          |
| --------------  | ------------------ |
| KVM             |:heavy_check_mark:  |
| None            |:heavy_check_mark:  |
| Qemu            |:heavy_check_mark:  |
| LXC             |:heavy_check_mark:  |
| Microsoft       |:heavy_check_mark:  |
| Vmware          |:heavy_check_mark:  |
| OpenVZ          |:heavy_check_mark:  |
| Docker          |:heavy_check_mark:  |
| Wsl             |:heavy_check_mark:  |
