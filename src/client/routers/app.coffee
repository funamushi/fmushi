class Fmushi.Routers.App extends Backbone.Router
  initialize: ->
    @route ':userName', 'home'
    @route ':userName/mushies/:mushiId', 'mushi'
    @route 'signin', 'signin'
    @route 'signup', 'signup'

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
    
  signin: ->

  signup: ->
    