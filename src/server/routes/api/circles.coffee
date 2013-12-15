exports.index = (req, res) ->
  res.send [
    {
      id: 1
      x: 0
      y: 50
      r: 300
      state: 'hustle'
      lineColor: '#F4D6E0'
      fillColor: '#DE7699'
    }
    {
      id: 2
      x: 600
      y: 550
      r: 200
      state: 'rest'
      lineColor: '#D6E9C9'
      fillColor: '#72C575'
    }
    {
      id: 3
      x: 1400
      y: 700
      r: 150
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
