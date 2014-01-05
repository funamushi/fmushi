class Fmushi.Scenes.Login extends Fmushi.Scenes.Base
  initialize: ->
    form = new Fmushi.Views.LoginForm
    @$el.append form.render().el
    @subview 'form', form

    @trigger 'load:complete'

