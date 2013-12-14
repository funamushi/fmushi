exports.index = (req, res) ->
  res.send [
    { id: 2, x: 0, y: 50, r: 400 }
    { id: 1, x: 600, y: 550, r: 200 }
  ]
