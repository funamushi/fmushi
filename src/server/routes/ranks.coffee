exports.index = (req, res) ->
  res.send [
    { id: 1, level: 1, name: '一等兵' }
    { id: 2, level: 2, name: '代表取締まり役' }
    { id: 3, level: 3, name: 'テクニカルマネージャー' }
  ]
