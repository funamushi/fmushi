Fmushi = require 'fmushi'

module.exports = class AppRouter extends Backbone.Router
  routes:
    'signup': 'signup'
    ':userName': 'home'
    ':userName/mushies/:mushiId': 'mushi'
    '': 'root'

  scene: (name, options={}) ->
    if name isnt @currentSceneName
      prev = Fmushi.scene
      if prev?
        prev.transitionOut().done ->
          prev.dispose()

      Scene = require("scenes/#{name}")
      Fmushi.scene = nextScene = new Scene(options)
      nextScene.once 'ready', ->
        nextScene.transitionIn()

      @currentSceneName = name

  home: (userName) ->
    @scene 'home', userName: userName
    
  mushi: (userName, mushiId) ->
    @scene 'home', userName: userName, focusMushiId: mushiId

  signup: ->
    @scene 'signup'

  root: ->
    viewer = Fmushi.viewer
    if viewer.loggedIn
      @scene 'home', userName: viewer.get('name')
      Backbone.history.navigate viewer.url()
    else
      @scene 'home'
