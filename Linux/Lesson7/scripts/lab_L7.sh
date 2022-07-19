#!/bin/bash

echo "Enter number of users to create: "
read N
echo "Creating $N users..."
echo "======================"

for i in $(seq $N); do

    echo "1_Enter user name #$i: "
    read NAME
    echo "Creating user $NAME..."
    sudo useradd -ms /bin/bash $NAME
    

    echo "2_Enter Password for $NAME:"
    sudo passwd $NAME
    read -s PW
    echo "------------------"
    echo "Done Creating user #$i/$N!"
    echo "------------------"

done

echo "======================"

echo "$N Users have been successfully created!"