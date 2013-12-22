class Fmushi.Routers.App extends Backbone.Router
  routes:
    '': 'home'
    'signin': 'signin'

  startScene: (name) ->
    sceneClassName = name.replace /(?:^|[-_])(\w)/g, (_, c) ->
      if c? then c.toUpperCase() else ''

    Fmushi.scene?.dispose()
    Fmushi.scene = new Fmushi.Scenes[sceneClassName]
    Fmushi.scene.start()
    
  home: ->
    @startScene 'home'

  signin: ->
    console.log 'signin'