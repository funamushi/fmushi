E = {
  WEAPON1: 1  
}

exports.index = (req, res) ->
  res.send [
    {
      id: 1
      name: 'プヤプヤプンヤ'
      rankId: 1
      x: 700
      y: 50
      equipments: [
        { type: 'weapon', itemId: 1 }
      ]
    }
    {
      id: 2,
      name: 'ヘイプー'
      rankId: 2
      x: 850
      y: 200
    }
    {
      id: 3
      name: 'がちゅん'
      rankId: 3
      x: 1000
      y: 350,
      equipments: [
        { type: 'weapon', itemId: 2 }
      ]
    }
  ]
