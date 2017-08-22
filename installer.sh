#!/bin/bash
installScript(){       
 printf "Downloading $1 from GitHub... "
 eval "wget -q" $3 
 if [ $? -eq 0 ]; then
    printf "Success.\nInstalling $1... "
    eval "chmod +x $2.sh"
    eval "sudo mv $2.sh /usr/bin/$2"
    if [ $? -eq 0 ]; then
     printf "Success.\nInstalled $1 successfully.\n"
    fi
 else
    printf 'Fail\nError downloading, check network connection.\n'
 fi
 if [ $2 == 'autossh' ]; then
  autosshAddData
 fi
 printf "\n"
}

autosshAddData(){
 printf '\nAutoSSH configuration:\n'
 printf 'Default Username to use: '
 read user
 sudo sed -i "s/\[default login\]/$user/g" /usr/bin/autossh
 printf 'Default MAC Address to use: '
 read mac

 if [[ $mac =~ ^([a-fA-F0-9]{2}:){5}[a-fA-F0-9]{2}$ ]]; then
 sudo sed -i "s/\[default device MAC address\]/$mac/g" /usr/bin/autossh
 else
  printf 'Invalid MAC address.\n'
  autosshAddData
 fi
}

if sudo -n false 2>/dev/null; then 
 echo "Installation of nettools requires root access, please enter your password:"
 sudo -v
fi
printf "\e[4mnettools installer\e[0m\n"
#installScript "[Display Name]" "[Command Name]" "[Script Link]"
installScript "AutoSSH" "autossh" "https://raw.githubusercontent.com/ExlerCS/nettools/master/scripts/autossh.sh"
installScript "lsip" "lsip" "https://raw.githubusercontent.com/ExlerCS/nettools/master/scripts/lsip.sh"
