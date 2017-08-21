#!/bin/bash
installScript(){       
 printf "Downloading $1 from GitHub... "
 eval "wget -q" $3 
 if [ $? -eq 0 ]; then
    printf "Success\nInstalling $1... "
      if [ $2 == 'piconnect' ]; then
  	piconnectAddData
      fi
    eval "chmod +x $2.sh"
    eval "sudo mv $2.sh /usr/bin/$2"
    if [ $? -eq 0 ]; then
     printf "Success\nInstalled $1 successfully.\n"
    fi
 else
    printf 'Fail\nError downloading, check network connection.\n'
 fi
 printf "\n"
}

piconnectAddData(){
 printf '\nPiConnect configuration:\n'
 printf 'Default Username to use: '
 read user
 sed -i "s/\[default login\]/$user/g" piconnect.sh
 printf 'Default MAC Address to use: '
 read mac

 if [[ $mac =~ ^([a-fA-F0-9]{2}:){5}[a-fA-F0-9]{2}$ ]]; then
  sed -i "s/\[default device MAC address\]/$mac/g" piconnect.sh
 else
  printf 'Invalid MAC address.\n'
  piconnectAddData
 fi
}

if sudo -n false 2>/dev/null; then 
 echo "Installation of nettools requires root access, please enter your password:"
 sudo -v
fi
printf "\e[4mnettools installer\e[0m\n"
#installScript "[Display Name]" "[Command Name]" "[Script Link]"
installScript "PiConnect" "piconnect" "https://raw.githubusercontent.com/tkmarsh/PiConnect/master/piconnect.sh"
installScript "lsip" "lsip" "https://raw.githubusercontent.com/tkmarsh/lsip/master/lsip.sh"
