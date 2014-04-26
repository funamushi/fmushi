exports.set = (req, res, next, userName) ->
  next()

exports.show = (req, res) ->
  res.format
    html: ->
      res.render 'index'

    json: ->
      res.send
        name: 'hadashiA'
        mushies: [
          {
            id: 1
            name: 'ヘイプー大佐'
            x: 200
            y: 200
          }
          {
            id: 2
            name: 'ミニマム級チャンピオン ワンツーぷや夫'
            x: 500
            y: 200
          }
          {
            id: 3
            name: 'プヤプヤプンヤ代表取締役'
            x: 700
            y: 200
          }
        ]
        circles: [
          {
            id: 1
            x: 700
            y: 650
            r: 200
          }
        ]

exports.mushi = (req, res) ->
  res.render 'index'
