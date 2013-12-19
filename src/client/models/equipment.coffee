class Fmushi.Models.Equipment extends Backbone.Model
  set: (key, val, options) ->
    if typeof key is 'object'
      attrs = key
      options = val
    else
      (attrs = {})[key] = val

    if itemId = attrs.itemId
      @item = Fmushi.items.get(itemId)
    super attrs, options


class Fmushi.Collections.Equipments extends Backbone.Collection
  model: Fmushi.Models.Equipment