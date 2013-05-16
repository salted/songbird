Campfire  = require('campfire').Campfire
Twitter   = require('twit')

class Songbird

  constructor: (options) ->
    @campfire = new Campfire options.campfire
    @twitter  = new Twitter  options.twitter

  identify: (callback) ->
    @twitter.get 'account/verify_credentials', (error, user) =>
      @user = user
      callback()

  fly: (room_id) ->
    @campfire.room room_id, (error, room) =>
      @room = room

  sonar: (search) ->
    @twitter.stream('statuses/filter', search).on 'tweet', (tweet) =>
      @sing tweet

    @twitter.stream('user').on 'favorite', (message) =>
      if message.target.screen_name is @user.screen_name
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
