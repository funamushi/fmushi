class Fmushi.Models.Mushi extends Backbone.Model
  defaults: ->
    src: "/img/funamushi.png"
    x: 0
    y: 0
    r: 60

  initialize: ->

  pos: ->
    new Fmushi.Vector @get('x'), @get('y')

class Fmushi.Collections.Mushies extends Backbone.Collection
  model: Fmushi.Models.Mushi