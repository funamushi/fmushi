Fmushi = require 'fmushi'

module.exports = class AppRouter extends Backbone.Router
  routes:
    'signup': 'signup'
    ':userName': 'home'
    ':userName/mushies/:mushiId': 'mushi'
    '': 'root'

  home: (userName) ->
    @scene 'home', userName: userName
    
  mushi: (userName, mushiId) ->
    @scene 'home', userName: userName, zoomMushiId: mushiId

  signup: ->
    @scene 'signup'

  root: ->
    viewer = Fmushi.viewer
    if viewer.loggedIn
      @scene 'home', userName: viewer.get('name')
      Backbone.history.navigate viewer.url()
    else
      @scene 'home'

  scene: (name, options={}) ->
    Fmushi.scene name, options