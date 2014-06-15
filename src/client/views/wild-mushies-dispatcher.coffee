Fmushi   = require 'fmushi'
Breed    = require 'models/breed'
Mushi    = require 'models/mushi'
BaseView = require 'views/base'

module.exports = class WildMushiesDispatcher extends BaseView
  minInterval: 5

  initialize: (options) ->
    @owner = options.owner
    @listenTo @collection, 'remove', @resetTimer
    @resetTimer()

  resetTimer: ->
    return if @collection.length > 0

    interval = @nextIntervalToAppearance()
    interval = Math.max(@minInterval, interval) if @timerStarted

    clearTimeout @timerId
    @timerId = setTimeout =>
      @appearance()
    , (interval * 1000)

    @timerStarted = true

  nextIntervalToAppearance: ->
    owner = @owner
    count = @collection.length
    
    # 次に出現する時間を来める
    if not owner.loggedIn
      0
    else
      7

  appearance: ->
    size = Fmushi.screenSize
    camera = @owner.get('camera')
    breed = new Breed
    breed.fetchSample().then =>
      mushi = new Mushi
        breed: breed
        x: size.w
        y: _.random(size.h * 0.1, size.h * 0.9)
      @collection.add mushi
      mushi.appearance()

      @lastAppearanceAt = new Date

  dispose: ->
    clearTimeout @timerId
    