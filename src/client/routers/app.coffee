class Fmushi.Routers.App extends Backbone.Router
  initialize: ->
    @route ':userName', 'home'
    @route ':userName/mushies/:mushiId', 'mushi'
    @route 'login', 'login'
    @route 'register', 'register'
    @route '', 'root'

  replaceScene: (name, options={}) ->
    sceneClassName = name.replace /(?:^|[-_])(\w)/g, (_, c) ->
      if c? then c.toUpperCase() else ''

    if name isnt @currentSceneName
      Fmushi.scene?.dispose()
      Fmushi.scene = new Fmushi.Scenes[sceneClassName](options)
      @currentSceneName = name

  home: (userName) ->
    @replaceScene 'home', userName: userName
    
  mushi: (userName, mushiId) ->
    @replaceScene 'home', userName: userName, focusMushiId: mushiId

  register: ->
    @replaceScene 'register'

  login: ->
    @replaceScene 'login'

  root: ->
    viewer = Fmushi.viewer
    if viewer.authorized
      Backbone.history.navigate viewer.url()
    else
      Backbone.history.navigate '/register'