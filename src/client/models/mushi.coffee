Fmushi     = require 'fmushi'
Vector     = require 'vector'
Circle     = require 'models/circle'
Equipments = require 'collections/equipments'

module.exports = class Mushi extends Backbone.AssociatedModel
  defaults: ->
    x: 0
    y: 0
    groth: 1
    direction: 'left'

  relations: [
    {
      type: Backbone.One
      key: 'circle'
      relatedModel: Circle
    }
    {
      type: Backbone.Many
      key: 'equipments'
      collectionType: Equipments
    }
  ]

  initialize: ->
    @r = 30 * @get('groth') # body

  pos: ->
    new Vector @get('x'), @get('y')

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
  