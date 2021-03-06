Fmushi = require 'fmushi'
User = require 'models/user'
BaseScene = require 'scenes/base'
template = require 'templates/signup'

module.exports = class SignupScene extends BaseScene
  events:
    'change #user-name': 'onChangeName'
    'input  #user-name': 'onChangeName'
    'paste  #user-name': 'onChangeName'
    'click .ladda-button': 'onSubmit'

  initialize: (options) ->
    viewer = Fmushi.viewer
    @listenTo viewer, 'change:name', @showValidate

    @render()
    @trigger 'ready'

  render: ->
    @$el.html template(user: Fmushi.viewer.toJSON())
    @$userName = @$('#user-name')
    @$userNameContainer = @$userName.closest('.form-group')

    @$button = @$('.signup-button')
    @ladda = Ladda.create @$button[0]
    @

  showValidate: ->
    if Fmushi.viewer.isValid()
      @$userNameContainer
      .removeClass('has-error').addClass('has-success')
      .find('.input-icon').show()
      @$button.removeAttr 'disabled'
    else
      @$userNameContainer
      .removeClass('has-success').addClass('has-error')
      .find('.input-icon').hide
      @$button.attr 'disabled', 'disabled'

  transitionOut: ->
    defer = $.Deferred()
    $(@el).transition
      perspective: '100px'
      rotateY: '180deg'
    , -> defer.resolve()
    defer.promise()

  onChangeName: (e) ->
    Fmushi.viewer.set 'name', e.target.value

  onSubmit: (e) ->
    e.preventDefault()
    
    ladda = @ladda
    ladda.start()

    if save = Fmushi.viewer.signup()
      save
      .then (viewer) ->
        Fmushi.viewer.set(viewer)
        Fmushi.scene 'home', userName: Fmushi.viewer.get('name')
        Backbone.history.navigate Fmushi.viewer.url()
      .fail =>
        @showValidate()
        ladda.stop()
    else
      @showValidate()
      ladda.stop()
