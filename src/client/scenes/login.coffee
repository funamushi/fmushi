class Fmushi.Scenes.Login extends Fmushi.Scenes.Base
  initialize: ->
    form = new Fmushi.Views.LoginForm
    @$el.append form.render().el
    @subview 'form', form

    setTimeout ( => @trigger 'ready'), 20

