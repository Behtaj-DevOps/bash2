#!/bin/bash
## Backup the original source.lost file
sudo cp /etc/apt/sources.list /etc/apt/sources_Backup

echo "#####################################"
echo " Source list backuped!"
echo "#####################################"
## Delete the contents of sources.list
# echo  "" | sudo tee -a /etc/apt/sources.list


# Add new link to sources.list
cat<<EOF > /etc/apt/sources.list
deb http://deb.debian.org/debian bullseye main contrib non-free
# deb-src http://deb.debian.org/debian bullseye main contrib non-free

deb http://deb.debian.org/debian bullseye-updates main contrib non-free
# deb-src http://deb.debian.org/debian bullseye-updates main contrib non-free

 deb http://deb.debian.org/debian bullseye-backports main contrib non-free
# deb-src http://deb.debian.org/debian bullseye-backports main contrib non-free

deb http://security.debian.org/debian-security bullseye-security main contrib non-free
# deb-src http://security.debian.org/debian-security bullseye-security main contrib non-free
EOF

echo "#####################################"
echo " Source list updated!"
echo "#####################################"
### Set up proxy for apt-get
# echo "Acquire::http::Proxy \"http://username:password@proxy.server:port/\";" > /etc/apt/apt.conf.d/proxy.conf

## Check if OS is Debian
if [ "$(uname -s)" = "Linux" ] && [ -f "/etc/debian_version" ]; then
     # Install packages without user interaction
    sudo apt-get update
    sudo apt-get install -y aptitude policykit-1 apt-transport-https python3-apt debian-archive-keyring 
fi
echo "#####################################"
echo " Debian packages are installed!"
echo "#####################################"

### Install packages without user interaction
sudo apt-get update
sudo apt-get install -y bash-completion curl htop iftop python3 python3-pip sudo tree vim wget unzip ncdu git gnupg2  ca-certificates lsb-release
echo "#####################################"
echo " General Packages are installed!"
echo "#####################################"


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

# Set NTP servers
sudo sed -i 's|#NTP=|NTP=ir.pool.ntp.org 0.asia.pool.ntp.org 1.asia.pool.ntp.org 2.asia.pool.ntp.org 3.asia.pool.ntp.org ntp1.net.berkeley.edu|g' /etc/systemd/timesyncd.conf

# Set fallback NTP servers
sudo sed -i 's|#FallbackNTP=|FallbackNTP=0.debian.pool.ntp.org 1.debian.pool.ntp.org 2.debian.pool.ntp.org 3.debian.pool.ntp.org|g' /etc/systemd/timesyncd.conf

# Set root distance max sec
sudo sed -i 's|#RootDistanceMaxSec=|RootDistanceMaxSec=5|g' /etc/systemd/timesyncd.conf

# Set poll interval min sec
sudo sed -i 's|#PollIntervalMinSec=|PollIntervalMinSec=32|g' /etc/systemd/timesyncd.conf

# Set poll interval max sec
sudo sed -i 's|#PollIntervalMaxSec=|PollIntervalMaxSec=2048|g' /etc/systemd/timesyncd.conf

echo "#####################################"
echo " Time Sync configured!"
echo "#####################################"

## Restart system-timesyncd service
sudo systemctl restart systemd-timesyncd.service

echo "#####################################"
echo " Time Sync Running now!"
echo "#####################################"

## Create a new user
sudo useradd kambiz -m -d /home/apartment -s /bin/bash -G sudo -p '$6$cAyhisYvbQ$u1uq3OYqOjGJerrMTdAiRlLXT0kuu5.p7nBU9hQoH.U4ul4BG4ZCzrbQbgiGD7EVF24FAMDTdbwDXeTD2xYaY1'

echo "#####################################"
echo "New user created!"
echo "#####################################"

## Set the full name
sudo chfn -f "Kambiz Khademi" kambiz

## Create SSH directory and authorized_keys file
sudo mkdir /home/apartment/.ssh
sudo touch /home/apartment/.ssh/authorized_keys

## Add SSH key to authorized_keys file
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCpCD5fQG6Z+MCZLuiryHQmG26TY6bRfYZGUKmexUyOuPT7vufWGeOaoN9eImdW1S7VZ8xV9sNqHnNFc13GqOo/4/29GtOTcunkXl9ihcsTczcKRbgwO5+kf8YnFWpZwscuEIzHYcGgvmmjJUm0U9WvORddJ7ZbY/4WsGKWAQVDDsY6J5zdk3rk/L2nb5PN8wVUYtCSU7f7U+3Ce9tmIVgjRTSyYQQB+uahnG/bo5popMuMEn8RjcTpRLi+AaUE+ztULbjzUjUncIhBPFzLA7jsi+s0wrviouZAkkGtxAA89o5SDo6+Z9V2BR10vkey5B2I3Xm4zKsiwZoRY5xq+6DcrIGvx5N8k86BttW0rOxkDyLAGelC9BU38u7njwltVFvf1CSYD67WbZeaC89m4APmhnZ2poU8pHUAqwkUExRRrVXkorlaS+fTb7vtGvl9LrO6gBp1bxnbkl5M3FN/q0Ed0MjmL3N78oY9wu4Ukz93BtuQly9R5+7y9IoXC4ydTsye/+H+C3RC3VNIPstNlDJqtWYb21/KqAiJ8XICOvIKSmkVDeP0DQUZziMeBfcotfAga8gVPpeD4o6AxGkQ0kHOSilVgfUZ/9taj4/As+1207FOJhU2t8pBSVmpTpi0uEu1O0e7lJGMxNylKltEIS4zNcvASOsYDJ8SPx0bVfRtCQ== nix@khademi.kambiz.gmail.com' >> /home/apartment/.ssh/authorized_keys
## Set ownership of SSH directory and authorized_keys file to user
sudo chown -R kambiz:kambiz /home/apartment/

## Set permissions of SSH directory and authorized_keys file
sudo chmod 700 /home/apartment/.ssh
sudo chmod 600 /home/apartment/.ssh/authorized_keys


echo "#####################################"
echo "New user's ssh access is enable now !"
echo "######################################"
