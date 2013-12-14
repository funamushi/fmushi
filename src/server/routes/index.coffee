module.exports =
  api: require('./api')

  siginup: (req, res) ->
    res.render 'siginup'

  signin: (req, res) ->
    res.render 'signin'

  home: (req, res) ->
    res.render 'home'