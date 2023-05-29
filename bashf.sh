#!/bin/bash

## Backup the original source.lost file
sudo cp /etc/apt/sources.list /etc/apt/sources_$(date "+%Y-%m-%d-%H-%M-%S")

echo "#####################################"
echo " Source list backuped!"
echo "#####################################"
## Delete the contents of sources.list
# echo  "" | sudo tee -a /etc/apt/sources.list

# Add Sources.list  to bash
sudo cp /home/behtaj/bash3/sources.list  /etc/apt/sources.list


echo "#####################################"
echo " Source list updated!"
echo "#####################################"

# check OS 

if [[ $(lsb_release -si) == "Debian" ]]; then
    echo "This is Debian"

elif [[ $(cat /etc/redhat-release) == *"Red Hat Enterprise Linux Server release 7"* ]]; then
    echo "This is Redhat7"

elif [[ $(cat /etc/redhat-release) == *"Red Hat Enterprise Linux release 8"* ]]; then
    echo "This is Redhat8"

elif [[ $(lsb_release -si) == "Fedora" ]]; then
    echo "This is Fedora"
fi

echo "####################################"
echo  " OS Checked "
echo "####################################"


## Check if OS is Debian
if [ "$(uname -s)" = "Linux" ] && [ -f "/etc/debian_version" ]; then
     # Install packages without user interaction
    sudo apt-get update
    sudo apt-get install -y  bash-completion curl htop iftop python3 python3-pip sudo tree vim wget unzip ncdu git gnupg2  ca-certificates lsb-release aptitude policykit-1 apt-transport-https python3-apt debian-archive-keyring 
    echo "#####################################"
    echo " Debian packages are installed!"
    echo "#####################################"

elif [[ $(lsb_release -si) == "RedHatEnterpriseServer" ]] || [[ $(lsb_release -si) == "Fedora" ]]; then
    sudo yum update -y
    sudo yum install -y   bash-completion curl htop iftop python3 python3-pip sudo tree vim wget unzip ncdu git gnupg2  ca-certificates lsb-release dnf
    echo "#####################################"
    echo " Redhat and Fedora  packages are installed!"
    echo "#####################################"
fi


### Stop and disable NTP service
sudo systemctl stop ntp
sudo systemctl disable ntp

## Remove NTP package and configuration files
sudo apt-get purge -y ntp
# sudo rm -rf /etc/ntp.conf
echo "#####################################"
echo " NTP removed!"
echo "#####################################"

## Stop and disable Chrony service
sudo systemctl stop chrony
sudo systemctl disable chrony

## Remove Chrony package and configuration files
sudo apt-get purge -y chrony
#sudo rm -rf /etc/chrony/chrony.conf
echo "#####################################"
echo " Chrony removed!"
echo "#####################################"

## Install system-timesyncd
sudo apt-get install systemd-timesyncd -y

echo "#####################################"
echo " Time Sync installed!"
echo "#####################################"
## Set timezone
sudo timedatectl set-timezone Asia/Tehran


# Add timesysncd.config file to bash 
sudo cp /home/behtaj/bash3/timesyncd.conf  /etc/systemd/timesyncd.conf

echo "#####################################"
echo " Time Sync configured!"
echo "#####################################"
## Restart system-timesyncd service
sudo systemctl restart systemd-timesyncd.service

echo "#####################################"
echo " Time Sync Running now!"
echo "#####################################"

sudo cp /etc/ssh/sshd_config  /etc/ssh/shd_config_$(date "+%Y-%m-%d-%H-%M-%S")
sudo cp /home/behtaj/bash3/sshd_config  /etc/ssh/sshd_config

echo "#####################################"
echo "  backup ssd_config "
echo "#####################################"
