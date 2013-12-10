exports.index = (req, res) ->
  res.send [
    { id: 1, name: '豆4カスタム', desc: 'めちゃ強な銃を強めた品' }
    { id: 2, name: '豆92F', desc: 'まじ強い銃' }
    { id: 3, name: '豆マグナム', desc: 'まじはんぱなく強い銃' }
  ]
