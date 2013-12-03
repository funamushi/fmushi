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

  parse: (res, options) ->
    @equipments = new Fmushi.Collections.Equipments res.equipments
    delete res.equipments
    res

  set: (key, val, options) ->
    if typeof key == 'object'
      attrs = key
      options = val
    else
      (attrs = {})[key] = val

    if rankId = attrs.rankId
      @rank = Fmushi.ranks.get(rankId)
    super attrs, options

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

class Fmushi.Collections.Mushies extends Backbone.Collection
  model: Fmushi.Models.Mushi
  url: '/mushies'