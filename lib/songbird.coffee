Campfire  = require('campfire').Campfire
Twitter   = require('twit')

class Songbird

  constructor: (options) ->
    @campfire = new Campfire options.campfire
    @twitter  = new Twitter  options.twitter

  fly: (room_id) ->
    @campfire.join room_id, (error, room) =>
      @room = room

  sonar: (search) ->
    @twitter.stream('statuses/filter', search).on 'tweet', (tweet) =>
      @sing tweet
    @twitter.stream('user').on 'favorite', (message) =>
      if message.target.screen_name is 'litmusapp'
        from    = message.source.screen_name
        phrase  = ":star: #{ from } favorited this tweet:"
        @room.speak phrase
        @sing message.target_object


  sing: (tweet) ->
    screen_name = tweet.user.screen_name
    id          = tweet.id_str
    url         = "https://twitter.com/#{ screen_name }/status/#{ id }"
    @room.tweet url

module.exports = Songbird
