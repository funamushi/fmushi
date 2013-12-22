class Fmushi.Routers.App extends Backbone.Router
  initialize: ->
    @route ':userName', 'home'
    @route ':userName/mushies/:mushiId', 'mushi'
    @route 'signin', 'signin'

  startScene: (name, options={}) ->
    sceneClassName = name.replace /(?:^|[-_])(\w)/g, (_, c) ->
      if c? then c.toUpperCase() else ''

    if name isnt @currentSceneName
      Fmushi.scene?.dispose()
      Fmushi.scene = new Fmushi.Scenes[sceneClassName](options)
      Fmushi.scene.start()
      @currentSceneName = name

  home: (userName) ->
    @startScene 'home', userName: userName

  mushi: (userName, mushiId) ->
    @startScene 'home', userName: userName, focusMushiId: mushiId
    
  siginin: ->