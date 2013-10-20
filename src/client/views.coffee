class Fmushi.Views.AppView extends Backbone.View
  initialize: ->
    @listenTo Fmushi.Events, 'update', ->
      console.log 'update'
