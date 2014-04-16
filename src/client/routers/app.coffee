module.exports = class AppRouter extends Backbone.Router
  initialize: ->
    @route ':userName', 'home'
    @route ':userName/mushies/:mushiId', 'mushi'
    @route '', 'root'

  scene: (name, options={}) ->
    sceneClassName = name.replace /(?:^|[-_])(\w)/g, (_, c) ->
      if c? then c.toUpperCase() else ''

    if name isnt @currentSceneName
      prev = Fmushi.scene
      if prev?
        prev.transitionOut().done ->
          prev.dispose()

      Fmushi.scene = nextScene = new Fmushi.Scenes[sceneClassName](options)
      @listenTo nextScene, 'ready', ->
        nextScene.transitionIn()

      @currentSceneName = name

  home: (userName) ->
    @scene 'home', userName: userName
    
  mushi: (userName, mushiId) ->
    @scene 'home', userName: userName, focusMushiId: mushiId

  root: ->
    viewer = Fmushi.viewer
    if viewer.loggedIn
      Backbone.history.navigate viewer.url(), trigger: true
    else
      @scene 'home'
