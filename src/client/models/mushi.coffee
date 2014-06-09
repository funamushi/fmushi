Fmushi = require 'fmushi'
Breed  = require 'models/breed'

module.exports = class Mushi extends Backbone.AssociatedModel
  defaults: ->
    x: 0
    y: 0
    direction: 'left'
    growth: 1
    state: 'walking'

  relations: [
    {
      type: Backbone.One
      key: 'breed'
      relatedModel: Breed
    }
  ]

  radius: ->
    @get('growth') * 50

  comment: ->
    _.sample [
      '右折しま〜す'
      '左折しま〜す'
      '大は小を兼ねるって言うし'
      '風来てる、風来てる'
      '酸素うまい'
    ]

  point: ->
    @trigger 'point:in'

  pointOut: ->
    @trigger 'point:out'

  capture: ->
    @set state: 'idle'
    @trigger 'capture', @

  release: ->
    @set state: 'walking'
    @trigger 'release', @
