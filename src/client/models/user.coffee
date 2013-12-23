class Fmushi.Models.User extends Backbone.Model
  defaults:
    fp: 0

  url: ->
    "/#{@get('name')}"

  validate: (attrs) ->
    if _.isEmpty(attrs.name)
      return true

  addFp: (fp) ->
    @set 'fp', @get('fp') + fp








