module.exports = elements =
  table: {}

  fetch: ->
    $.get('/elements').then (data) =>
      @table = data

  name: (element) ->
    @table[element]?.name

  inverse: (element) ->
    @table[element]?.inverse

  next: (element) ->
    @table[element]?.next

  prev: (element) ->
    @table[element]?.prev
