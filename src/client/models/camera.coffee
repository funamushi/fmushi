class Fmushi.Models.Camera extends Backbone.Model
  defaults:
    x: 0
    y: 0
    zoom: 1

  initialize: (options) ->
    @user = options.user
    @offset = { x: 0, y: 0 }

  clear: ->
    @offset.x = @offset.y = 0
