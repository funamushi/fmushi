class Fmushi.Views.Base extends Backbone.View
  constructor: ->
    @subviewsByName = {}
    super

  subview: (name, view) ->
    byName = @subviewsByName

    if name and view
      # Add the subview, ensure it’s unique.
      @removeSubview name
      byName[name] = view
      view
    else if name
      # Get and return the subview by the given name.
      byName[name]

  # Removing a subview.
  removeSubview: (nameOrView) ->
    return unless nameOrView
    byName = @subviewsByName

    if typeof nameOrView is 'string'
      # Name given, search for a subview by name.
      name = nameOrView
      view = byName[name]
    else
      # View instance given, search for the corresponding name.
      view = nameOrView
      for otherName, otherView of byName when otherView is view
        name = otherName
        break

    # Break if no view and name were found.
    return unless name and view and view.dispose

    # Dispose the view.
    view.dispose()

    # Remove the subview from the lists.
    delete byName[name]

  # Remove all handlers registered with @delegate.
  undelegate: (eventName, second, third) ->
    return super if Backbone.View::undelegate
    if eventName
      if typeof eventName isnt 'string'
        throw new TypeError 'View#undelegate: first argument must be a string'

      if arguments.length is 2
        if typeof second is 'string'
          selector = second
        else
          handler = second
      else if arguments.length is 3
        selector = second
        if typeof selector isnt 'string'
          throw new TypeError 'View#undelegate: ' +
            'second argument must be a string'
        handler = third

      list = ("#{event}.delegate#{@cid}" for event in eventName.split ' ')
      events = list.join(' ')
      @$el.off events, (selector or null)
    else
      @$el.off ".delegate#{@cid}"

  dispose: ->
    return if @disposed

    # Dispose subviews.
    subview.dispose() for subview, name in @subviewsByName

    # Remove all event handlers on this module.
    @off()

    # Check if view should be removed from DOM.
    if @keepElement
      # Unsubscribe from all DOM events.
      @undelegateEvents()
      @undelegate()
      # Unbind all referenced handlers.
      @stopListening()
    else
      # Remove the topmost element from DOM. This also removes all event
      # handlers from the element and all its children.
      @remove()

    # Remove element references, options,
    # model/collection references and subview lists.
    properties = [
      'el', '$el',
      'options', 'model', 'collection',
      'subviews', 'subviewsByName',
      '_callbacks'
    ]
    delete this[prop] for prop in properties

    # Finished.
    @disposed = true

    # You’re frozen when your heart’s not open.
    Object.freeze? this
    