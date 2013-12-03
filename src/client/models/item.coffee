class Fmushi.Models.Item extends Backbone.Model

class Fmushi.Collections.Items extends Backbone.Collection
  model: Fmushi.Models.Item

  url: '/items'
