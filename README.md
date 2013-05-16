<img src="songbird.jpg" style="width:100%;" />

# Songbird

A campfire bot that subscribes to the twitter streaming API and echoes any
tweets that match your search criteria into a chat room.

## Setup

1.  Set the following environment variables:
  *  CAMPFIRE\_ACCOUNT
  *  CAMPFIRE\_API\_KEY
  *  TWITTER\_CONSUMER\_KEY
  *  TWITTER\_CONSUMER\_SECRET
  *  TWITTER\_ACCESS\_TOKEN
  *  TWITTER\_ACCESS\_TOKEN\_SECRET

2.  Add Heroku repo

```bash
git remote add heroku git@heroku.com:litmus-twitterbot.git
```

## Run locally

```bash
./bin/songbird
```

## Deploy

```bash
git push heroku master
```
