class Fmushi.Models.User extends Backbone.Model
  defaults:
    fp: 0

  url: ->
    "/#{@get('name')}"

  validate: (attrs) ->
    errors = []

    if _.isEmpty(attrs.name)
      errors.push attr: 'name', message: '名前がありません。'

    if attrs.fp < 0
      errors.push attr: 'fp', message: '0以下にできません。'

    return errors if errors.length

  addFp: (fp) ->
    @set 'fp', @get('fp') + fp
