exports.findByName = (req, res, next, user) ->
  req.params.user =
    name: 'hadashiA', fp: 100
  next()

exports.show = (req, res) ->
  res.format
    html: ->
      res.render 'index'

    json: ->
      res.send req.params.user

exports.mushies =
  index: (req, res) ->
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
        id: 2
        name: 'プヤプヤプンヤ'
        rankId: 1
        x: 700
        y: 200
        equipments: [
          { type: 'weapon', itemId: 1 }
        ]
      }
      {
        id: 3
        name: 'プヤプヤプンヤ'
        rankId: 1
        x: 700
        y: 300
        equipments: [
          { type: 'weapon', itemId: 1 }
        ]
      }
    ]

  show: (req, res) ->
    res.format
      html: ->
        res.render 'home'

      json: ->
        res.send {}

exports.circles =
  index: (req, res) ->
    res.send [
      {
        id: 1
        x: 0
        y: 50
        r: 400
        state: 'hustle'
        lineColor: '#F4D6E0'
        fillColor: '#DE7699'
      }
      {
        id: 2
        x: 500
        y: 450
        r: 300
        state: 'rest'
        lineColor: '#D6E9C9'
        fillColor: '#72C575'
      }
      {
        id: 3
        x: 800
        y: 400
        r: 200
        state: 'walking'
        lineColor: '#CCE9F9'
        fillColor: '#4CBAEB'
      }
      # {
      #   id: 4
      #   x: 0
      #   y: 50
      #   r: 400
      #   state: 'mutate'
      #   lineColor: '#F9F4D6'
      #   fillColor: '#F7D663'
      # }
    ]
  