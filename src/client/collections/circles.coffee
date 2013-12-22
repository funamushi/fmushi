class Fmushi.Collections.Circles extends Backbone.Collection
  model: Fmushi.Models.Circle

  initialize: (models, options) ->
    @user = options.user

  url: ->
    @user.url() + '/circles'
  
