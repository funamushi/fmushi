module.exports = elements =
  table: {}

  fetch: ->
    $.get('/elements').then (data) =>
      @table = data

  name: (element) ->
    @table[element]?.name

  inverseName: (element) ->
    @table[element]?.inverseName

  next: (element) ->
    @table[element]?.next

  prev: (element) ->
    @table[element]?.prev
