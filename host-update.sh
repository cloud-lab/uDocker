#!/bin/bash

echo && echo
read -p "Please enter host node number: " new

if ! [ $new -eq $new ] 2>/dev/null ; then
        echo -e "$(tput setaf 1)!! Exit -- Sorry, integer only !!$(tput sgr0)"
        exit 1; fi
if [ -z $new ] || [ $new -lt 1 ] || [ $new -gt 254 ] ; then
        echo -e "$(tput setaf 1)!! Exit -- node number out of range !!$(tput sgr0)"
        exit 1; fi

new=$(echo $new | sed 's/^0*//')

oldhost=$(cat /etc/hostname)
oldip=$(cat /etc/network/interfaces | grep "iface enp0s3" -A 2 \
      | grep address | awk '{ print $2 }')

newhost=$(echo $oldhost | cut -d- -f1)-$new
newip=$(echo $oldip | cut -d. -f4 --complement).$new

sudo sed -i "s/$oldhost/$newhost/" /etc/hostname
sudo sed -i "s/$oldhost/$newhost/" /etc/hosts
sudo sed -i "s/$oldip/$newip/" /etc/network/interfaces

echo
echo "$(tput setaf 6)!! Update node name from $oldhost to $newhost !!"
echo "!! Update node name from $oldip to $newip !! $(tput sgr0)"
echo System will restart in 10 seconds
sleep 10

echo Restarting ........
sudo shutdown -r now
