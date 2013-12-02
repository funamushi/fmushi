class Fmushi.Models.Mushi extends Backbone.Model
  defaults: ->
    src: "/img/funamushi.png"
    x: 0
    y: 0
    groth: 1
    rankId: 1
    direction: 'left'

  initialize: ->
    @r = 60 * @get('groth') # body

    @on 'add', @updateRank
    @on 'change:rankId', @updateRank

  parse: (res, options) ->
    @equipments = new Fmushi.Collections.Equipments res.equipments
    delete res.equipments
    res

  pos: ->
    new Fmushi.Vector @get('x'), @get('y')

  comment: ->
    _.sample [
      '右折しま〜す'
      '左折しま〜す'
      '大は小を兼ねるって言うし'
      '風来てる、風来てる'
      '酸素うまい'
    ]

  updateRank: ->
    @rank = Fmushi.ranks.findById(@get('rankId'))

class Fmushi.Collections.Mushies extends Backbone.Collection
  model: Fmushi.Models.Mushi
  url: '/mushies'