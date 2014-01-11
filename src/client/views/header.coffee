class Fmushi.Views.Header extends Fmushi.Views.Base
  el: '#site-header nav'

  events:
    'click #login': 'login'
    'click #logout': 'logout'

  initialize: (options) ->
    model = @model

    @listenTo model, 'change:fp', =>
      @$('#fp').text model.get('fp')

    @listenTo model, 'authorize', =>
      @render()      

  render: ->
    loginHidden = !!Backbone.history.fragment.match(/register|login/)

    console.log JST['header']
      viewer: @model.toJSON()
      authorized: @model.authorized
      loginHidden: loginHidden


    @$el.html JST['header']
      viewer: @model.toJSON()
      authorized: @model.authorized
      loginHidden: loginHidden
    @

  login: ->

  logout: ->
    if confirm 'ログアウトする?'
      1
      
      
      