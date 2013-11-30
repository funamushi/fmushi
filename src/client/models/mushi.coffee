class Fmushi.Models.Mushi extends Backbone.Model
  defaults: ->
    src: "/img/funamushi.png"
    x: 0
    y: 0
    r: 60
    direction: 'left'

  initialize: ->

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