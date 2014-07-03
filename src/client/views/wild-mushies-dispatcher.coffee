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
    if owner.isNew()
      1
    else
      7

  appearance: ->
    worldSize = Fmushi.worldSize
    size   = Fmushi.windowSize
    camera = @owner.get('camera')
    right  = camera.worldX(size.w)
    bottom = camera.worldY(size.h)

    breed = new Breed
    breed.fetchSample().then =>
      mushi = new Mushi
        breed: breed
        state: 'wild'
        x: _.random(worldSize * 0.5, worldSize)
        y: _.random(worldSize * 0.25, worldSize * 0.9)
      @collection.add mushi
      mushi.appearance()

      @lastAppearanceAt = new Date

  dispose: ->
    clearTimeout @timerId
    