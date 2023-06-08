#!/bin/bash
# set -a 

# ./usrs.sh 

source usrs.txt
# Create a new user
sudo useradd $Username -m -d /home/$HomeDirectoryName -s /bin/bash -G sudo -p $Password

echo "#####################################"
echo "New user created!"
echo "#####################################"

## Set the full name
sudo chfn -f "$Fullname" $Username

## Create SSH directory and authorized_keys file
sudo mkdir /home/$HomeDirectoryName/.ssh
sudo touch /home/$HomeDirectoryName/.ssh/authorized_keys

## Add SSH key to authorized_keys file
echo $SSH_Key >> sudo /home/$HomeDirectoryName/.ssh/authorized_keys
## Set ownership of SSH directory and authorized_keys file to user
sudo chown -R $Username:$Username /home/$HomeDirectoryName/

## Set permissions of SSH directory and authorized_keys file
sudo chmod 700 /home/$HomeDirectoryName/.ssh
sudo chmod 600 /home/$HomeDirectoryName/.ssh/authorized_keys


echo "#####################################"
echo "New user's ssh access is enable now !"
echo "######################################"
