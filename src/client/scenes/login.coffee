class Fmushi.Scenes.Login extends Fmushi.Scenes.Base
  initialize: ->
    form = new Fmushi.Views.RegisterForm
    @$el.append form.render().el
    @subview 'form', form

    setTimeout ( => @trigger 'ready'), 20

