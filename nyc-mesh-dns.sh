#!/usr/bin/env bash

# NYC MESh DNS Script

# Check if the script is running as root
function check_root() {
    if [ "$(id -u)" -ne 0 ]; then
        echo "Error: This script must be run as root."
        exit 1
    fi
}

# Call the function to check root privileges
check_root

# Function to gather current system details
function system-information() {
    # This function fetches the ID, version, and major version of the current system
    if [ -f /etc/os-release ]; then
        # If /etc/os-release file is present, source it to obtain system details
        # shellcheck source=/dev/null
        source /etc/os-release
        CURRENT_DISTRO=${ID}                                                                              # CURRENT_DISTRO holds the system's ID
        CURRENT_DISTRO_VERSION=${VERSION_ID}                                                              # CURRENT_DISTRO_VERSION holds the system's VERSION_ID
        CURRENT_DISTRO_MAJOR_VERSION=$(echo "${CURRENT_DISTRO_VERSION}" | cut --delimiter="." --fields=1) # CURRENT_DISTRO_MAJOR_VERSION holds the major version of the system (e.g., "16" for Ubuntu 16.04)
    fi
}

# Invoke the system-information function
system-information

# Define a function to check system requirements
function installing-system-requirements() {
    # Check if the current Linux distribution is supported
    if { [ "${CURRENT_DISTRO}" == "ubuntu" ] || [ "${CURRENT_DISTRO}" == "debian" ] || [ "${CURRENT_DISTRO}" == "raspbian" ] || [ "${CURRENT_DISTRO}" == "pop" ] || [ "${CURRENT_DISTRO}" == "kali" ] || [ "${CURRENT_DISTRO}" == "linuxmint" ] || [ "${CURRENT_DISTRO}" == "neon" ] || [ "${CURRENT_DISTRO}" == "fedora" ] || [ "${CURRENT_DISTRO}" == "centos" ] || [ "${CURRENT_DISTRO}" == "rhel" ] || [ "${CURRENT_DISTRO}" == "almalinux" ] || [ "${CURRENT_DISTRO}" == "rocky" ] || [ "${CURRENT_DISTRO}" == "arch" ] || [ "${CURRENT_DISTRO}" == "archarm" ] || [ "${CURRENT_DISTRO}" == "manjaro" ] || [ "${CURRENT_DISTRO}" == "alpine" ] || [ "${CURRENT_DISTRO}" == "freebsd" ] || [ "${CURRENT_DISTRO}" == "ol" ]; }; then
        # Check if required packages are already installed
        if { [ ! -x "$(command -v curl)" ] || [ ! -x "$(command -v cut)" ] || ! -x "$(command -v cron)" ] || ! -x "$(command -v ps)" ]; }; then
            # Install required packages depending on the Linux distribution
            if { [ "${CURRENT_DISTRO}" == "ubuntu" ] || [ "${CURRENT_DISTRO}" == "debian" ] || [ "${CURRENT_DISTRO}" == "raspbian" ] || [ "${CURRENT_DISTRO}" == "pop" ] || [ "${CURRENT_DISTRO}" == "kali" ] || [ "${CURRENT_DISTRO}" == "linuxmint" ] || [ "${CURRENT_DISTRO}" == "neon" ]; }; then
                apt-get update
                apt-get install curl coreutils cron procps -y
            elif { [ "${CURRENT_DISTRO}" == "fedora" ] || [ "${CURRENT_DISTRO}" == "centos" ] || [ "${CURRENT_DISTRO}" == "rhel" ] || [ "${CURRENT_DISTRO}" == "almalinux" ] || [ "${CURRENT_DISTRO}" == "rocky" ]; }; then
                yum check-update
                yum install curl coreutils cronie -y
            elif { [ "${CURRENT_DISTRO}" == "arch" ] || [ "${CURRENT_DISTRO}" == "archarm" ] || [ "${CURRENT_DISTRO}" == "manjaro" ]; }; then
                pacman -Sy --noconfirm archlinux-keyring
                pacman -Su --noconfirm --needed curl coreutils cronie procps-ng
            elif [ "${CURRENT_DISTRO}" == "alpine" ]; then
                apk update
                apk add curl coreutils cronie procps
            elif [ "${CURRENT_DISTRO}" == "freebsd" ]; then
                pkg update
                pkg install curl coreutils cronie procps
            elif [ "${CURRENT_DISTRO}" == "ol" ]; then
                yum check-update
                yum install curl coreutils cronie procps-ng -y
            fi
        fi
    else
        echo "Error: Your current distribution ${CURRENT_DISTRO} version ${CURRENT_DISTRO_VERSION} is not supported by this script. Please consider updating your distribution or using a supported one."
        exit
    fi
}

# Call the function to check for system requirements and install necessary packages if needed
installing-system-requirements

### Global Variables
CURRENT_INIT_SYSTEM=$(ps --no-headers -o comm 1) # CURRENT_INIT_SYSTEM holds the name of the init system (e.g., "systemd" or "init")

# Install bind on the system if bind is not found.
function install-bind-server() {
    if [ ! -x "$(command -v named)" ]; then
        if { [ "${CURRENT_DISTRO}" == "ubuntu" ] || [ "${CURRENT_DISTRO}" == "debian" ] || [ "${CURRENT_DISTRO}" == "raspbian" ] || [ "${CURRENT_DISTRO}" == "pop" ] || [ "${CURRENT_DISTRO}" == "kali" ] || [ "${CURRENT_DISTRO}" == "linuxmint" ] || [ "${CURRENT_DISTRO}" == "neon" ]; }; then
            apt-get update
            apt-get install bind9 -y
        elif { [ "${CURRENT_DISTRO}" == "fedora" ] || [ "${CURRENT_DISTRO}" == "centos" ] || [ "${CURRENT_DISTRO}" == "rhel" ] || [ "${CURRENT_DISTRO}" == "almalinux" ] || [ "${CURRENT_DISTRO}" == "rocky" ] || [ "${CURRENT_DISTRO}" == "ol" ]; }; then
            yum check-update
            yum install bind -y
        elif { [ "${CURRENT_DISTRO}" == "arch" ] || [ "${CURRENT_DISTRO}" == "archarm" ] || [ "${CURRENT_DISTRO}" == "manjaro" ]; }; then
            pacman -Sy --noconfirm archlinux-keyring
            pacman -Su --noconfirm --needed bind
        elif [ "${CURRENT_DISTRO}" == "alpine" ]; then
            apk update
            apk add bind
        elif [ "${CURRENT_DISTRO}" == "freebsd" ]; then
            pkg update
            pkg install bind
        fi
    fi
}

# Call the function to install bind server
install-bind-server

# Function to configure bind server
function configure-bind-server() {
    # Check if the bind server is installed
    if [ -x "$(command -v named)" ]; then
    # Download the latest version of the config from the server.
    curl https://raw.githubusercontent.com/nycmeshnet/nycmesh-dns/main/named.conf -o /etc/bind/named.conf
    # Restart the bind server
    if [[ "${CURRENT_INIT_SYSTEM}" == *"systemd"* ]]; then
        systemctl restart bind
    elif [[ "${CURRENT_INIT_SYSTEM}" == *"init"* ]]; then
        service bind restart
    fi
}

# Call the function to configure bind server
configure-bind-server

# Function to install knot-resolver on the system
function install-knot-resolver() {
    if [ ! -x "$(command -v kresd)" ]; then
        if { [ "${CURRENT_DISTRO}" == "ubuntu" ] || [ "${CURRENT_DISTRO}" == "debian" ] || [ "${CURRENT_DISTRO}" == "raspbian" ] || [ "${CURRENT_DISTRO}" == "pop" ] || [ "${CURRENT_DISTRO}" == "kali" ] || [ "${CURRENT_DISTRO}" == "linuxmint" ] || [ "${CURRENT_DISTRO}" == "neon" ]; }; then
            apt-get update
            apt-get install knot-resolver knot -y
        elif { [ "${CURRENT_DISTRO}" == "fedora" ] || [ "${CURRENT_DISTRO}" == "centos" ] || [ "${CURRENT_DISTRO}" == "rhel" ] || [ "${CURRENT_DISTRO}" == "almalinux" ] || [ "${CURRENT_DISTRO}" == "rocky" ] || [ "${CURRENT_DISTRO}" == "ol" ]; }; then
            yum check-update
            yum install knot-resolver knot -y
        elif { [ "${CURRENT_DISTRO}" == "arch" ] || [ "${CURRENT_DISTRO}" == "archarm" ] || [ "${CURRENT_DISTRO}" == "manjaro" ]; }; then
            pacman -Sy --noconfirm archlinux-keyring
            pacman -Su --noconfirm --needed knot-resolver knot
        elif [ "${CURRENT_DISTRO}" == "alpine" ]; then
            apk update
            apk add knot-resolver knot
        elif [ "${CURRENT_DISTRO}" == "freebsd" ]; then
            pkg update
            pkg install knot-resolver knot
        fi
    fi
}

# Call the function to install knot-resolver
install-knot-resolver

# Function to configure knot-resolver
function configure-knot-resolver() {
    # Check if the knot-resolver is installed
    if [ -x "$(command -v kresd)" ]; then
        # Download the latest version of the config from the server.
        curl https://raw.githubusercontent.com/nycmeshnet/nycmesh-dns/main/kresd.conf -o /etc/knot-resolver/kresd.conf
        # Restart the knot-resolver service
        if [[ "${CURRENT_INIT_SYSTEM}" == *"systemd"* ]]; then
            systemctl restart kresd
        elif [[ "${CURRENT_INIT_SYSTEM}" == *"init"* ]]; then
            service kresd restart
        fi
    fi
}

# Call the function to configure knot-resolver
configure-knot-resolver
