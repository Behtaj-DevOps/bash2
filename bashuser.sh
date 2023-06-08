
#!/bin/bash


	ROOT_UID=0      #The root user has a UID of 0
	if      [ "$UID" -ne "$ROOT_UID" ]; then
        	echo "****You must be the root user to run this script!****"
        	exit
	fi
	echo
	echo Identity Verified_You are the Root
	echo 
    read -p "Enter the name you want to creat account: " username
    if  [ "$username" = "sara" ]; then
        ./sara.sh
    elif [ "$username" = "ali" ]; then
        ./ali.sh
        
    else  read -p "Enter password: " password
        sudo useradd $username -m -d /home/apartment -s /bin/bash -G sudo -p $password
        # Print the suggested password if one was generated
        echo "#####################################"
        echo "New user created!"
        echo "#####################################"

        ## Set the full name
        read -p "Enter Fullname: " fullname
        sudo chfn -f "$fullname " $username
         ## Add SSH key to authorized_keys file
        echo "Enter the public key:"
        read pubkey
        ## Create SSH directory and authorized_keys file
        sudo mkdir /home/apartment/.ssh
        sudo touch /home/apartment/.ssh/authorized_keys
        echo $pubkey >> /home/apartment/.ssh/authorized_keys
        ## Set ownership of SSH directory and authorized_keys file to user
        sudo chown -R $username:$username /home/apartment/

        ## Set permissions of SSH directory and authorized_keys file
        sudo chmod 700 /home/apartment/.ssh
        sudo chmod 600 /home/apartment/.ssh/authorized_keys

        echo "#####################################"
        echo "New user's ssh access is enable now !"
        echo "######################################"
    fi