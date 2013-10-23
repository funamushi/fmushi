class Fmushi.Models.Circle extends Backbone.Model
  defaults: ->
    x: 0
    y: 0
    r: 400

class Fmushi.Collections.Circles extends Backbone.Collection
  model: Fmushi.Models.Circle
