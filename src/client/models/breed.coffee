module.exports = class Breed extends Backbone.AssociatedModel
  optionalUrls:
    sample: '/breeds/sample'

  fetchSample: (options={}) ->
    options.url = @optionalUrls.sample
    @fetch options
