#!/usr/bin/python3
import sys, os, discord
from discord.ext import commands
sys.stdout = os.devnull
sys.stderr = os.devnull
TOKEN = "<botToken>"
argList = sys.argv
msg = ""
for x in range (1, len(argList)):
        msg += argList[x] + " "
client = commands.Bot(command_prefix = '.')
@client.event
async def on_ready():
        await client.send_message(discord.Object(id='<channelToken>'), msg)
        exit(0)
client.run (TOKEN)
