window.Fmushi =
  Models: {}
  Collections: {}
  Views: {}
  Scenes: {}
  Routers: {}
  Events: _.extend {}, Backbone.Events
  debug: false
  initialize: ->
    @router = new Fmushi.Routers.App
    Backbone.history.start pushState: true, root: '/'

class Fmushi.Vector extends Two.Vector
  toJSON: ->
    { x: @x, y: @y }

Fmushi.vec2 = (x, y) ->
   new Fmushi.Vector(x, y)

$ ->
  Fmushi.initialize()
 