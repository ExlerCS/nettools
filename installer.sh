 
#!/bin/bash

installScripts()
{       
 printf 'Downloading PiConnect from GitHub...\n'
 wget -q https://raw.githubusercontent.com/tkmarsh/PiConnect/master/piconnect.sh
 if [ $? -eq 0 ]; then
    printf 'Installing PiConnect...\n'
    chmod +x piconnect.sh
    sudo mv piconnect.sh /usr/bin/piconnect
    if [ $? -eq 0 ]; then
     printf 'Installed PiConnect successfully.\n'
    fi
 else
    printf 'Error downloading, check network connection.\n'
 fi
 
 printf '\nDownloading lsip from GitHub...\n'
 wget -q https://raw.githubusercontent.com/tkmarsh/lsip/master/lsip.sh
 if [ $? -eq 0 ]; then
    printf 'Installing lsip...\n'
    chmod +x lsip.sh
    sudo mv lsip.sh /usr/bin/lsip
    if [ $? -eq 0 ]; then
     printf 'Installed lsip successfully.\n'
    fi    
 else
    printf 'Error downloading, check network connection.\n'
 fi
}

if sudo -n true 2>/dev/null; then 
       installScripts
     else
       echo "Installation of nettools requires root access, please enter your password:"
       sudo -v
       installScripts
     fi
