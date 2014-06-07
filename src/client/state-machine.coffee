module.exports = class StateMachene
  constructor: (model) ->
    @model = model
    @to model.get('state')

  to: (name) ->
    return if name is @currentState
    state = @states[name]
    return unless state?

    @currentState?.onExit? @view
    @currentState = state
    state.onEnter? @view
    
  update: (delta) ->
    @currentState?.update @model, delta
