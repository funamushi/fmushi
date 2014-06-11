Fmushi   = require 'fmushi'
Breed    = require 'models/breed'
Mushi    = require 'models/mushi'
BaseView = require 'views/base'

module.exports = class WildMushiesDispatcher extends BaseView
  interval: 5

  initialize: (options) ->
    @owner = options.owner
    @listenTo @collection, 'remove', @resetTimer
    @resetTimer()

  resetTimer: ->
    return if @collection.length > 0

    clearTimeout @timerId
    @timerId = setTimeout =>
      @appearance()
    , @nextTimeToAppearance()

  nextTimeToAppearance: ->
    owner = @owner
    count = @collection.length
    
    # 次に出現する時間を来める
    time =
      if not owner.loggedIn
        0
      else
        7

    # 前回の出現から最低限置きたい時間を計算する
    msec = (new Date) - (@lastAppearanceAt or new Date)
    sec  = msec * 0.001
    interval = Math.max 0, (@interval - sec)

    Math.max time, interval

  appearance: ->
    size = Fmushi.screenSize
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
    