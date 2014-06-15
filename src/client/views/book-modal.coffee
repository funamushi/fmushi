BaseView = require 'views/base'
template = require 'templates/book'

module.exports = class BookModalView extends BaseView
  open: ->
    vex.open
      content: template(user: @model.toJSON())
      
    
