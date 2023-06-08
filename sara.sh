#!/bin/bash
# Create a new user
sudo useradd sara -m -d /home/apartment -s /bin/bash -G sudo -p '$6$cAyhisYvbQ$u1uq3OYqOjGJerrMTdAiRlLXT0kuu5.p7nBU9hQoH.U4ul4BG4ZCzrbQbgiGD7EVF24FAMDTdbwDXeTD2xYaY1'

echo "#####################################"
echo "New user created!"
echo "#####################################"

## Set the full name
sudo chfn -f "Sara Asadi" sara

## Create SSH directory and authorized_keys file
sudo mkdir /home/apartment/.ssh
sudo touch /home/apartment/.ssh/authorized_keys

## Add SSH key to authorized_keys file
echo 'ssh-rsa saraAAAAB3NzaC1yc2EAAAADAQABAAACAQCpCD5fQG6Z+MCZLuiryHQmG26TY6bRfYZGUKmexUyOuPT7vufWGeOaoN9eImdW1S7VZ8xV9sNqHnNFc13GqOo/4/29GtOTcunkXl9ihcsTczcKRbgwO5+kf8YnFWpZwscuEIzHYcGgvmmjJUm0U9WvORddJ7ZbY/4WsGKWAQVDDsY6J5zdk3rk/L2nb5PN8wVUYtCSU7f7U+3Ce9tmIVgjRTSyYQQB+uahnG/bo5popMuMEn8RjcTpRLi+AaUE+ztULbjzUjUncIhBPFzLA7jsi+s0wrviouZAkkGtxAA89o5SDo6+Z9V2BR10vkey5B2I3Xm4zKsiwZoRY5xq+6DcrIGvx5N8k86BttW0rOxkDyLAGelC9BU38u7njwltVFvf1CSYD67WbZeaC89m4APmhnZ2poU8pHUAqwkUExRRrVXkorlaS+fTb7vtGvl9LrO6gBp1bxnbkl5M3FN/q0Ed0MjmL3N78oY9wu4Ukz93BtuQly9R5+7y9IoXC4ydTsye/+H+C3RC3VNIPstNlDJqtWYb21/KqAiJ8XICOvIKSmkVDeP0DQUZziMeBfcotfAga8gVPpeD4o6AxGkQ0kHOSilVgfUZ/9taj4/As+1207FOJhU2t8pBSVmpTpi0uEu1O0e7lJGMxNylKltEIS4zNcvASOsYDJ8SPx0bVfRtCQ== nix@sara.asadibiz.gmail.com' >> /home/apartment/.ssh/authorized_keys
## Set ownership of SSH directory and authorized_keys file to user
sudo chown -R sara:sara /home/apartment/

## Set permissions of SSH directory and authorized_keys file
sudo chmod 700 /home/apartment/.ssh
sudo chmod 600 /home/apartment/.ssh/authorized_keys


echo "#####################################"
echo "New user's ssh access is enable now !"
echo "######################################"
