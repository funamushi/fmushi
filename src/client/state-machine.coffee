class Fmushi.StateMachene
  constructor: (@view) ->

  to: (name) ->
    return if name is @currentState
    state = mushiStates[name]
    return unless state?

    @currentState?.onExit? @view
    @currentState = state
    @currentState.onEnter? @view
    
  update: (delta) ->
    @currentState?.update @view, delta
