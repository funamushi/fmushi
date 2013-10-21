class Fmushi.Models.Mushi extends Backbone.Model
  defaults:
    x: 0
    y: 0

class Fmushi.Collections.Mushies extends Backbone.Collection
  model: Fmushi.Models.Mushi