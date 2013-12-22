class Fmushi.Routers.App extends Backbone.Router
  initialize: ->
    @route /^(\w+)$/, 'home'
    @route /^(\w+)\/mushies\/(\d+)$/, 'mushi'
    @route 'signin', 'signin'

  startScene: (name, options) ->
    sceneClassName = name.replace /(?:^|[-_])(\w)/g, (_, c) ->
      if c? then c.toUpperCase() else ''

    if name isnt @currentSceneName
      Fmushi.scene?.dispose()
      Fmushi.scene = new Fmushi.Scenes[sceneClassName]
      Fmushi.scene.start()
      @currentSceneName = name

  home: (userName) ->
    @startScene 'home'

  mushi: (userName, mushiId) ->
    @startScene 'home'
    
  siginin: ->