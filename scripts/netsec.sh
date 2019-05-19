#!/bin/bash
installPyModule(){
printf "Installing $1..."
python3 -m pip install $1
        if [ $? -eq 0 ]; then
                printf "Successfully installed $1.\n"
        else
                printf "Fail.\nError installing $1.\n"
                exit 1
        fi
}

installPyModule "setuptools"
installPyModule "-U discord.py"
printf "Downloading sshrc from github..."
wget https://raw.githubusercontent.com/ExlerCS/nettools/master/data/sshrc
if [ $? -eq 0 ]; then
	mv sshrc /etc/ssh/sshrc
else
	printf "Failed to download config"
	exit 1
fi
printf "Downloading Discord bot script..."
wget https://raw.githubusercontent.com/ExlerCS/nettools/master/scripts/discordBotTemplate.py
if [ $? -eq 0 ]; then
	printf 'Enter Bot Token: '
	read bot
	sed -i "s/\<botToken\>/$bot/g" discordBotTemplate.py
	printf 'Enter Channel Token: '
	read channel
	sed -i "s/\<channelToken\>/$channel/g" discordBotTemplate.py 
	mv discordBotTemplate.py /home/$USER/.scripts/discord-ssh.py
else
        printf "Failed to download script"
	rm discordBotTemplate.sh
	rm sshrc
        exit 1
fi

