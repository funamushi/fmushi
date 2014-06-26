Fmushi = require 'fmushi'
StateMachine = require 'state-machine'

module.exports = class MushiStateMachine extends StateMachine
  states:
    wild:
      speed: 45
      onEnter: ->
        @distanceElapsed = 0
        @distanceLimit = (Fmushi.worldSize.w * 0.4)

      update: (model, delta) ->
        distance = @speed * delta
        @distanceElapsed += distance

        x = model.get('x')
        newX = (x - distance)
        model.set 'x', newX
        model.disappearance() if @distanceElapsed >= @distanceLimit

    rest:
      update: (model, delta) ->

    walking:
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
