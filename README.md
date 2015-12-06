#Game-Logger
A website to maintain and share one's collection of retro video games for my
CS504 class.

Current version of site hosted at [GameLogger.co](https://gamelogger.co)
(if my domain name is still being wonky, you can still get to the website through [Heroku](https://game-logger.herokuapp.com))

~~Accompanying Android app repo is [over here](https://github.com/HerrSchreiber/game-logger-app)~~
Android app abandoned, but API still works
##API
All API requests require an API key which you can generate with a POST to /api/v1/login
with the request body "email=your-email&password=your-password"
The response will look like: {"api\_key":"H3TqfTvtJCpy5N6oFzsP8w"}

| Function                    | HTTP Method | URI                             | Query String(GET) or Request Body(POST)   | Example Response                 |
|-----------------------------|-------------|---------------------------------|-------------------------------------------|----------------------------------|
| Login/get API key           | POST        | /api/v1/login                   | "email=your-email&password=your-password" | {<br>api\_key:H3TqfTvtJCpy5N6oFzsP8w<br>} |
| User info                   | GET         | /api/v1/user/:user\_id           | "api\_key=your-api-key"                    | {<br>"id":1,<br>"name":"Rob",<br>"collection":[list-of-games]<br>}|
| User followers              | GET         | /api/v1/user/:user\_id/followers | "api\_key=your-api-key"                    | {<br>"id":1,<br>"name":"Rob",<br>"following":[list-of-users]<br>}|
| User following              | GET         | /api/v1/user/:user\_id/following | "api\_key=your-api-key"                    | {<br>"id":1,<br>"name":"Rob",<br>"followers":[list-of-users]<br>}|
| Follow user                 | POST        | /api/v1/user/:user\_id/follow    | "api\_key=your-api-key"                    | same as user following (reflecting the change)|
| Unfollow user               | DELETE      | /api/v1/user/:user\_id/follow    | "api\_key=your-api-key"                    | same as user following (reflecting the change)|
| Game info                   | GET         | /api/v1/game/:game\_id           | "api\_key=your-api-key"                    | {<br>"id":379,<br>"title":"Mario Bros.",<br>"platform":"NES",<br>"publisher":"Nintendo",<br>"release":"June 1986",<br>"owners":[list-of-users]<br>}|
| Add game to collection      | POST        | /api/v1/game/:game\_id           | "api\_key=your-api-key"                    | same as user info (reflecting the change)|
| Remove game from collection | DELETE      | /api/v1/game/:game\_id           | "api\_key=your-api-key"                    | same as user info (reflecting the change)|
| Search for game by title    | GET         | /api/v1/game/search/:game\_title | "api\_key=your-api-key"                    | [<br>{"id":75,<br>"title":"Battletoads",<br>"platform":"NES",<br>"release":"June 1991",<br>"publisher":"Tradewest"},<br>{"id":76,<br>"title":"Battletoads \u0026 Double Dragon",<br>"platform":"NES",<br>"release":"June 1993",<br>"publisher":"Tradewest"},<br>{"id":764,<br>"title":"Battletoads \u0026 Double Dragon",<br>"platform":"SNES",<br>"release":"12/1/1993",<br>"publisher":"Tradewest"},<br>{"id":765,<br>"title":"Battletoads in Battlemaniacs",<br>"platform":"SNES",<br>"release":"6/29/1993",<br>"publisher":"Tradewest"},<br>{"id":1555,<br>"title":"Battletoads \u0026 Double Dragon",<br>"platform":"Genesis",<br>"release":"1993",<br>"publisher":"Tradewest"}]|

Note, if any of the API calls fail, a response will be returned in the form of {"error":"Description of problem"}
