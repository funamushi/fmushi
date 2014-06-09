Fmushi = require 'fmushi'
Breed  = require 'models/breed'

module.exports = class WildMushiesDispatcher
  constructor: (@user, @wildMushies) ->

  start: ->
    @appearance()

  nextTimeToAppearance: ->
    user = @user
    if not user.loggedIn
      0
    else
      7

  dispose: ->
    clearTimeout @timerId

  appearance: ->
    size = Fmushi.screenSize
    breed = new Breed
    breed.fetchSample().then =>
      @wildMushies.add
        breed: breed
        state: 'wild'
        x: size.w
        y: _.random(size.h * 0.1, size.h * 0.9)
    