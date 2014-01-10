class Fmushi.Scenes.Register extends Fmushi.Scenes.Base
  initialize: ->
    form = new Fmushi.Views.RegisterForm isRegister: true
    @$el.append form.render().el
    @subview 'form', form

    setTimeout ( => @trigger 'ready'), 20
