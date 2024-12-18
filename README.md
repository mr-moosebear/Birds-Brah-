# Birds-Brah-

The game is going and I am finally at the point where I can
point out issues and logic that needs to be done.

The things that need to be worked on are...

- Save and load functions within the Global.gd res://Global.gd
Currently the save game function saves to a text file in the res://PlayerData
This needs to be done to user:// and since the only thing we are saving 
is an interger and probably a name in the future for a leaderboard.

if You check the Godot Docs for saving and loading is where I pulled the Logic
The Leaderboard will also need to be created which will probably be done with
database???(I wont go in depth on that yet)

- Top and bottom Obstacles need to spawn for level design res://Objects/
I have these set as node2d at the moment. I think a good way of doing this is all through code
with a character body as root of the node. I will also change this to be a one character body for both
the top and bottom and just flip the sprite when the position is greater than half the middle point of the 
screen

- Eventually this all needs to be set up for Android 

- Ideas
I consider making the background move instead of the bird because of how large
the Vector2 position x gets for the player character This might cause problems

  
