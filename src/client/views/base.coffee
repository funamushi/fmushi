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

  dispose: ->
    return if @disposed

    # Dispose subviews.
    _.forEach @subviewsByName, (subview, name) ->
      subview.dispose() 

    # Remove all event handlers on this module.
    @off()

    # Check if view should be removed from DOM.
    if @keepElement
      # Unsubscribe from all DOM events.
      @undelegateEvents()
      @$el.off()
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
    