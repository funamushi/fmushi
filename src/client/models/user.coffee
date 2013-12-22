class Fmushi.Models.User extends Backbone.Model
  defaults:
    fp: 0

  url: ->
    "/#{@get('name')}"

  addFp: (fp) ->
    @set 'fp', @get('fp') + fp








