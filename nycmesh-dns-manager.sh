#!/usr/bin/env bash

# Require script to be run as root
function super-user-check() {
  if [ "${EUID}" -ne 0 ]; then
    echo "Error: You need to run this script as administrator."
    exit
  fi
}

# Check for root
super-user-check

# Get the current system information
function system-information() {
  if [ -f /etc/os-release ]; then
    # shellcheck source=/dev/null
    source /etc/os-release
    CURRENT_DISTRO=${ID}
    CURRENT_DISTRO_VERSION=${VERSION_ID}
    CURRENT_DISTRO_MAJOR_VERSION=$(echo "${CURRENT_DISTRO_VERSION}" | cut --delimiter="." --fields=1)
  fi
}

# Get the current system information
system-information

# Note: Install the required crypto libraries so that we can easily do other stuff as well.

# Pre-Checks system requirements
function installing-system-requirements() {
  if { [ "${CURRENT_DISTRO}" == "ubuntu" ] || [ "${CURRENT_DISTRO}" == "debian" ] || [ "${CURRENT_DISTRO}" == "raspbian" ] || [ "${CURRENT_DISTRO}" == "pop" ] || [ "${CURRENT_DISTRO}" == "kali" ] || [ "${CURRENT_DISTRO}" == "linuxmint" ] || [ "${CURRENT_DISTRO}" == "neon" ] || [ "${CURRENT_DISTRO}" == "fedora" ] || [ "${CURRENT_DISTRO}" == "centos" ] || [ "${CURRENT_DISTRO}" == "rhel" ] || [ "${CURRENT_DISTRO}" == "almalinux" ] || [ "${CURRENT_DISTRO}" == "rocky" ] || [ "${CURRENT_DISTRO}" == "arch" ] || [ "${CURRENT_DISTRO}" == "archarm" ] || [ "${CURRENT_DISTRO}" == "manjaro" ] || [ "${CURRENT_DISTRO}" == "alpine" ] || [ "${CURRENT_DISTRO}" == "freebsd" ] || [ "${CURRENT_DISTRO}" == "ol" ]; }; then
    if { [ ! -x "$(command -v curl)" ] || [ ! -x "$(command -v cut)" ]; }; then
      if { [ "${CURRENT_DISTRO}" == "ubuntu" ] || [ "${CURRENT_DISTRO}" == "debian" ] || [ "${CURRENT_DISTRO}" == "raspbian" ] || [ "${CURRENT_DISTRO}" == "pop" ] || [ "${CURRENT_DISTRO}" == "kali" ] || [ "${CURRENT_DISTRO}" == "linuxmint" ] || [ "${CURRENT_DISTRO}" == "neon" ]; }; then
        apt-get update
        apt-get install curl coreutils -y
      elif { [ "${CURRENT_DISTRO}" == "fedora" ] || [ "${CURRENT_DISTRO}" == "centos" ] || [ "${CURRENT_DISTRO}" == "rhel" ] || [ "${CURRENT_DISTRO}" == "almalinux" ] || [ "${CURRENT_DISTRO}" == "rocky" ]; }; then
        yum check-update
        yum install curl coreutils -y
      elif { [ "${CURRENT_DISTRO}" == "arch" ] || [ "${CURRENT_DISTRO}" == "archarm" ] || [ "${CURRENT_DISTRO}" == "manjaro" ]; }; then
        pacman -Sy
        pacman -S --noconfirm --needed curl coreutils
      elif [ "${CURRENT_DISTRO}" == "alpine" ]; then
        apk update
        apk add curl coreutils
      elif [ "${CURRENT_DISTRO}" == "freebsd" ]; then
        pkg update
        pkg install curl coreutils
      elif [ "${CURRENT_DISTRO}" == "ol" ]; then
        yum check-update
        yum install curl coreutils -y
      fi
    fi
  else
    echo "Error: ${CURRENT_DISTRO} ${CURRENT_DISTRO_VERSION} is not supported."
    exit
  fi
}

# check for requirements
installing-system-requirements

# Only allow certain init systems
function check-current-init-system() {
  CURRENT_INIT_SYSTEM=$(ps --no-headers -o comm 1)
  case ${CURRENT_INIT_SYSTEM} in
  *"systemd"* | *"init"*) ;;
  *)
    echo "${CURRENT_INIT_SYSTEM} init is not supported (yet)."
    exit
    ;;
  esac
}

# Check if the current init system is supported
check-current-init-system

# Check if there are enough space to continue with the installation.
function check-disk-space() {
  FREE_SPACE_ON_DRIVE_IN_MB=$(df -m / | tr --squeeze-repeats " " | tail -n1 | cut --delimiter=" " --fields=4)
  if [ "${FREE_SPACE_ON_DRIVE}" -le 1024 ]; then
    echo "Error: More than 1 GB of free space is needed to install everything."
    exit
  fi
}

# Check if there is enough disk space
check-disk-space

# Glboal variables
URL_OF_KNOT_CONF="https://raw.githubusercontent.com/fX4N1DmH311X39SpxXLWxMWy49n6o8zb/nycmesh-dns/master/assets/knot.conf"
PATH_OF_KNOT_CONF="/etc/knot/knot.conf"
URL_OF_KRESD_CONF="https://raw.githubusercontent.com/fX4N1DmH311X39SpxXLWxMWy49n6o8zb/nycmesh-dns/master/assets/kresd.conf"
PATH_OF_KRESD_CONF="/etc/kresd/kresd.conf"
URL_OF_MESH_ZONE="https://raw.githubusercontent.com/fX4N1DmH311X39SpxXLWxMWy49n6o8zb/nycmesh-dns/master/assets/mesh.zone"
PATH_OF_MESH_ZONE="/etc/knot/mesh.zone"
# Cron names for differnet distros
if { [ "${CURRENT_DISTRO}" == "fedora" ] || [ "${CURRENT_DISTRO}" == "centos" ] || [ "${CURRENT_DISTRO}" == "rhel" ] || [ "${CURRENT_DISTRO}" == "almalinux" ] || [ "${CURRENT_DISTRO}" == "rocky" ]; }; then
  SYSTEM_CRON_NAME="crond"
elif { [ "${CURRENT_DISTRO}" == "arch" ] || [ "${CURRENT_DISTRO}" == "archarm" ] || [ "${CURRENT_DISTRO}" == "manjaro" ]; }; then
  SYSTEM_CRON_NAME="cronie"
else
  SYSTEM_CRON_NAME="cron"
fi

# Install bind server
function install-bind-server() {
  if { [ "${CURRENT_DISTRO}" == "ubuntu" ] || [ "${CURRENT_DISTRO}" == "debian" ] || [ "${CURRENT_DISTRO}" == "raspbian" ] || [ "${CURRENT_DISTRO}" == "pop" ] || [ "${CURRENT_DISTRO}" == "kali" ] || [ "${CURRENT_DISTRO}" == "linuxmint" ] || [ "${CURRENT_DISTRO}" == "neon" ]; }; then
    apt-get update
    apt-get install bind9 -y
  elif { [ "${CURRENT_DISTRO}" == "fedora" ] || [ "${CURRENT_DISTRO}" == "centos" ] || [ "${CURRENT_DISTRO}" == "rhel" ] || [ "${CURRENT_DISTRO}" == "almalinux" ] || [ "${CURRENT_DISTRO}" == "rocky" ]; }; then
    yum check-update
    yum install epel-release -y
    yum install bind -y
  elif { [ "${CURRENT_DISTRO}" == "arch" ] || [ "${CURRENT_DISTRO}" == "archarm" ] || [ "${CURRENT_DISTRO}" == "manjaro" ]; }; then
    pacman -Sy
    pacman -S --noconfirm --needed bind
  elif [ "${CURRENT_DISTRO}" == "alpine" ]; then
    apk update
    apk add bind
  elif [ "${CURRENT_DISTRO}" == "freebsd" ]; then
    pkg update
    pkg install bind
  elif [ "${CURRENT_DISTRO}" == "ol" ]; then
    yum check-update
    yum install bind -y
  fi
}

# Install bind server
install-bind-server

# Install knot server
function install-knot-server() {
  if { [ "${CURRENT_DISTRO}" == "ubuntu" ] || [ "${CURRENT_DISTRO}" == "debian" ] || [ "${CURRENT_DISTRO}" == "raspbian" ] || [ "${CURRENT_DISTRO}" == "pop" ] || [ "${CURRENT_DISTRO}" == "kali" ] || [ "${CURRENT_DISTRO}" == "linuxmint" ] || [ "${CURRENT_DISTRO}" == "neon" ]; }; then
    apt-get update
    curl "https://secure.nic.cz/files/knot-resolver/knot-resolver-release.deb" -o "knot-resolver-release.deb"
    dpkg -i knot-resolver-release.deb
    apt-get update
    apt-get install knot-resolver -y
  elif { [ "${CURRENT_DISTRO}" == "fedora" ] || [ "${CURRENT_DISTRO}" == "centos" ] || [ "${CURRENT_DISTRO}" == "rhel" ] || [ "${CURRENT_DISTRO}" == "almalinux" ] || [ "${CURRENT_DISTRO}" == "rocky" ]; }; then
    yum check-update
    yum install knot-resolver -y
  elif { [ "${CURRENT_DISTRO}" == "arch" ] || [ "${CURRENT_DISTRO}" == "archarm" ] || [ "${CURRENT_DISTRO}" == "manjaro" ]; }; then
    pacman -Sy
    pacman -S --noconfirm --needed knot-resolver
  elif [ "${CURRENT_DISTRO}" == "alpine" ]; then
    apk update
    apk add knot-resolver
  elif [ "${CURRENT_DISTRO}" == "freebsd" ]; then
    pkg update
    pkg install knot-resolver
  elif [ "${CURRENT_DISTRO}" == "ol" ]; then
    yum check-update
    yum install knot-resolver -y
  fi
}

# Install the latest config.
function install-latest-configs() {
  curl ${URL_OF_KNOT_CONF} --create-dirs -o ${PATH_OF_KNOT_CONF}
  curl ${URL_OF_KRESD_CONF} --create-dirs -o ${PATH_OF_KRESD_CONF}
  curl ${URL_OF_MESH_ZONE} --create-dirs -o ${PATH_OF_MESH_ZONE}
  # Need to expand on this and check the SHA-512 hash of the file; and determine if its time to update every day at 00:00
}

install-lastes-configs

# Auto update the configs each day at 00:00
function auto-update-configs() {
  # Check that its intslled before trying to install configs
  if [ -x "$(command -v knot)" ]; then
    # knot.conf
    if [ -f "${PATH_OF_KNOT_CONF}" ]; then
      CURRENT_HASH_OF_KNOT_CONFIG=$(openssl dgst -sha3-512 "${PATH_OF_KNOT_CONF}" | cut --delimiter=" " --fields=2)
      NEW_HASH_OF_KNOT_CONFIG=$(curl --silent "${URL_OF_KNOT_CONF}" | openssl dgst -sha3-512 | cut --delimiter=" " --fields=2)
      if [ "${CURRENT_HASH_OF_KNOT_CONFIG}" != "${NEW_HASH_OF_KNOT_CONFIG}" ]; then
        curl "${URL_OF_KNOT_CONF}" -o "${PATH_OF_KNOT_CONF}"
        chmod +x "${PATH_OF_KNOT_CONF}"
      fi
    fi
    # kresd.conf
    if [ -f "${PATH_OF_KRESD_CONF}" ]; then
      CURRENT_HASH_OF_KRESD_CONFIG=$(openssl dgst -sha3-512 "${PATH_OF_KRESD_CONF}" | cut --delimiter=" " --fields=2)
      NEW_HASH_OF_KRESD_CONFIG=$(curl --silent "${URL_OF_KRESD_CONF}" | openssl dgst -sha3-512 | cut --delimiter=" " --fields=2)
      if [ "${CURRENT_HASH_OF_KRESD_CONFIG}" != "${NEW_HASH_OF_KRESD_CONFIG}" ]; then
        curl "${URL_OF_KRESD_CONF}" -o "${PATH_OF_KRESD_CONF}"
        chmod +x "${PATH_OF_KRESD_CONF}"
      fi
    fi
    # mesh.zone
    if [ -f "${PATH_OF_MESH_ZONE}" ]; then
      CURRENT_HASH_OF_MESH_ZONE=$(openssl dgst -sha3-512 "${PATH_OF_MESH_ZONE}" | cut --delimiter=" " --fields=2)
      NEW_HASH_OF_MESH_ZONE=$(curl --silent "${URL_OF_MESH_ZONE}" | openssl dgst -sha3-512 | cut --delimiter=" " --fields=2)
      if [ "${CURRENT_HASH_OF_MESH_ZONE}" != "${NEW_HASH_OF_MESH_ZONE}" ]; then
        curl "${URL_OF_MESH_ZONE}" -o "${PATH_OF_MESH_ZONE}"
        chmod +x "${PATH_OF_MESH_ZONE}"
      fi
    fi
  fi
}

auto-update-configs
