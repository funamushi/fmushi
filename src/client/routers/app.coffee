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
      prev = Fmushi.scene
      if prev?
        prev.transitionOut()
        prev.$el.on 'transitionend', ->
          prev.dispose()

      Fmushi.scene = nextScene = new Fmushi.Scenes[sceneClassName](options)
      @listenTo nextScene, 'ready', =>
        nextScene.$el.addClass @currentSceneName
        nextScene.transitionIn()

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
    if viewer.loggedIn
      Backbone.history.navigate viewer.url(), trigger: true
    else
      Backbone.history.navigate '/login', trigger: true
