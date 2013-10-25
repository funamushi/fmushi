class Fmushi.Models.Mushi extends Backbone.Model
  defaults: ->
    src: "/img/funamushi.png"
    x: 0
    y: 0
    r: 70

class Fmushi.Collections.Mushies extends Backbone.Collection
  model: Fmushi.Models.Mushi