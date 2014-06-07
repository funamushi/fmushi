StateMachine = require 'state-machine'

module.exports = class MushiStateMachine extends StateMachine
  states:
    wild:
      speed: 35
      update: (model, delta) ->
        x = model.get('x')
        newX = (x - @speed * delta)
        model.set 'x', newX
        model.destroy() if newX <= 0

    rest:
      update: (model, delta) ->

    walking:
      speed: 30
      update: (model, delta) ->
        return if view.gripped

        x = model.get('x')
        if model.get('direction') is 'left'
          if x < -10
            model.set direction: 'right'
          else
            model.set x: x - @speed * delta
        else
          if x > 1000
            model.set direction: 'left'
          else
            model.set x: x + @speed * delta
    
    hustle:
      speed: 30
      update: (model, delta) ->
        x = model.get('x')
        if model.get('direction') is 'left'
          if x < -10
            model.set direction: 'right'
          else
            model.set x: x - @speed * delta
        else
          if x > 1000
            model.set direction: 'left'
          else
            model.set x: x + @speed * delta
