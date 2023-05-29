
#!/bin/bash

read -p "Enter the name you want to search for: " username


    # Check if the user is in the list
if  grep "$username" usrs.txt; then
   echo "User exists"
       
fi

