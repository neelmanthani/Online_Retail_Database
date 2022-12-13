# bot.py
# This file is intended to be a "getting started" code example for students.
# The code in this file is fully functional.
# Students are free to edit the code in the milestone 3 folder.
# Students are NOT allowed to distribute this code without the express permission of the class instructor
# IMPORTANT: How to set your secret environment variables? read README guidelines.

# imports
import os
import discord
import database as db
import bot

# environment variables
token = os.environ['DISCORD_TOKEN']
server = os.environ['DISCORD_GUILD']
# server_id = os.environ['SERVER_ID']  # optional
# channel_id = os.environ['CHANNEL_ID']  # optional

intents=discord.Intents.default()
intents.message_content = True

# database connection
# secret keys related to your database must be updated. Otherwise, it won't work
# db_conn = db.connect()
db.load_procedures_triggers_functions()
# bot events
client = discord.Client(intents = intents)

@client.event
async def on_ready():
    """
    This method triggers with the bot connects to the server
    Note that the sample implementation here only prints the
    welcome message on the IDE console, not on Discord
    :return: VOID
    """
    print("{} has joined the server".format(client.user.name))


@client.event
async def on_message(message):
    """
    This method triggers when a user sends a message in any of your Discord server channels
    :param message: the message from the user. Note that this message is passed automatically by the Discord API
    :return: VOID
    """
    response = None # will save the response from the bot
    if message.author == client.user:
        return # the message was sent by the bot
    if message.type is discord.MessageType.new_member:
        response = "Welcome {}".format(message.author) # a new member joined the server. Welcome him.
    else:
        # A message was send by the user.
        msg = message.content.lower()
        response = bot.response(msg)
    if response:
        # bot sends response to the Discord API and the response is show
        # on the channel from your Discord server that triggered this method.
      
        # embed = discord.Embed(description=response)

       #large messages get split due to discord's 2000 character limit policy
        if (len(response) <= 2000):
          await message.channel.send(response)
        else:
          i = 0
          while i < len(response):
            await message.channel.send(response[i: i+2000])
            i += 2000;


try:
    # start the bot and keep the above methods listening for new events
    client.run(token)
except:
    print("Bot is offline because your secret environment variables are not set. Head to the left panel, " +
          "find the lock icon, and set your environment variables. For more details, read the README file in your " +
          "milestone 3 repository")