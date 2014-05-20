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

Handlebars.registerHelper 'elementName', (element) ->
  name = elements.name(element)
  html = "<span class=\"element-#{element} circle\">#{name}</span>"
  new Handlebars.SafeString html

Handlebars.registerHelper 'elementNextName', (element) ->
  nextElement = elements.next(element)
  Handlebars.helpers.elementName nextElement

Handlebars.registerHelper 'elementPrevName', (element) ->
  prevElement = elements.prev(element)
  Handlebars.helpers.elementName prevElement

Handlebars.registerHelper 'elementInverseName', (element) ->
  name = elements.inverseName(element)
  html = "<span class=\"element-#{element} circle\">#{name}</span>"
  new Handlebars.SafeString html

Handlebars.registerHelper 'circle', (element) ->
  html = "<span class=\"element-icon-#{element}\">&#x2B24;</span>"
  new Handlebars.SafeString html
  
