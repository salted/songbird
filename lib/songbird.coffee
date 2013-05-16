Campfire  = require('campfire').Campfire
Twitter   = require('twit')

# Public: A campfire bot that will echo tweets you subscribe to in the channel
# of your choice.
class Songbird

  # Public: Initialize the bot
  #
  # options - The Hash of options used to configure campfire and twitter
  constructor: (options) ->
    @campfire = new Campfire options.campfire
    @twitter  = new Twitter  options.twitter

  # Public: Fetch the user object associated to the twitter oauth credentials
  #
  # callback - The Function to run after the twitter api call resolves
  #
  # Returns nothing.
  identify: (callback) ->
    @twitter.get 'account/verify_credentials', (error, user) =>
      @user = user
      callback()

  # Public: Joins a campfire room
  #
  # room_id - An Integer of the campfire room's unique id
  #
  # Returns nothing.
  fly: (room_id) ->
    @campfire.room room_id, (error, room) =>
      @room = room

  # Public: Subscribes to events and keywords on the twitter streaming api
  #
  # search - An Array of Strings to search for
  #
  # Examples
  #
  #   sonar([ 'bitcoin', '4chan' ])
  #
  # Returns nothing.
  sonar: (search) ->
    params =
      follow: [ @user.id_str ]
      track:  search

    @twitter.stream('statuses/filter', params).on 'tweet', (tweet) =>
      @sing tweet

    @twitter.stream('user').on 'favorite', (message) =>
      if message.target.screen_name is @user.screen_name
        from    = message.source.screen_name
        phrase  = ":star: #{ from } favorited this tweet:"
        @room.speak phrase
        @sing message.target_object

  # Public: Posts a tweet in a campfire room
  #
  # tweet - A Tweet object from twitter api
  #
  # Returns nothing.
  sing: (tweet) ->
    screen_name = tweet.user.screen_name
    id          = tweet.id_str
    url         = "https://twitter.com/#{ screen_name }/status/#{ id }"
    @room.tweet url

module.exports = Songbird
