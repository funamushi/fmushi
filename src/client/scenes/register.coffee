class Fmushi.Scenes.Register extends Fmushi.Scenes.Base
  initialize: ->
    form = new Fmushi.Views.LoginForm isRegister: true
    @$el.append form.render().el
    @subview 'form', form

    @trigger 'load:complete'

