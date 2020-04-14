# Global Gaming Community Project


Game type: role-playing is a unique type of game designed from nothing in which players are biased to quote an imagined character or represent the life of a real player

It is programmed in a game called mta sa, which is an online game adapted from Grand Theft Game. The most famous of them is to play them unrealistically, but in this genre we hope to turn the game into a realistic game

# New Features!

  - account system
  - save system
  - mysql
  - notif


### Functions

| Resource | Functions | Arguments | README | Side |
| --------- | --------- | --------- | ------------------- |------------------- |
| save-system | getPlayerid | thePlayer | You can get player id | Shared |
| mysql | singleQuery | dbString | you can send a simpel query to database with out dbConnect() | Server |
| mysql | execute | dbString | you can send a simpel execute to database with out dbConnect() | server |
| notif | drawNotif | string(type) , string(text) | draw new notifcation to the player | client |


### Elements

| Resource | Elements | Arguments | README |
| --------- | -------- | --------- | ------ |
| save-system| id|thePlayer|you can get player id|
| account | playerName |thePlayer| you can get playername

### Events

| Resource | EventName | Arguments | README |
| --------- | -------- | --------- | ------ |
| notif| drawNotif | string(type) , string(text) | draw new notifcation to the player |
