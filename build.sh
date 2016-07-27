#!/bin/bash -ex

##first install needed packages
apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends \
    openssh-server \
    openjdk-8-jdk sudo
apt-get clean

##tweak ssh
sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd
mkdir -p /var/run/sshd

##add jenkins user
adduser --disabled-password --gecos '' jenkins
echo "jenkins:jenkins" | chpasswd
adduser jenkins sudo
echo 'Defaults env_keep = "http_proxy https_proxy ftp_proxy"' >> /etc/sudoers
echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

rm /build.sh