class Fmushi.Models.Rank extends Backbone.Model

class Fmushi.Collections.Ranks extends Backbone.Collection
  model: Fmushi.Models.Rank

  url: '/ranks'

  findById: (id) ->
    @findWhere id: id