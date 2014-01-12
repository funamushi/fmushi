describe Fmushi.Models.Camera, ->
  describe '#validate', ->
    beforeEach ->
      @camera = new Fmushi.Models.Camera x: 100, y: 100, zoom: 1

    it 'xは0未満にできない', ->
      @camera.set 'x', -1
      expect(@camera.isValid()).to.not.be.ok
      expect(@camera.validationError[0].attr).to.equal('x')

    it 'yは0未満にできない', ->
      @camera.set 'y', -1
      expect(@camera.isValid()).to.not.be.ok
      expect(@camera.validationError[0].attr).to.equal('y')

    it 'zoomは0未満にできない', ->
      @camera.set 'zoom', -1
      expect(@camera.isValid()).to.not.be.ok
      expect(@camera.validationError[0].attr).to.equal('zoom')

    it 'zoomは0.01未満にできない', ->
      @camera.set 'zoom', 0.009
      expect(@camera.isValid()).to.not.be.ok
      expect(@camera.validationError[0].attr).to.equal('zoom')

    it 'zoomは3以上にできない', ->
      @camera.set 'zoom', 3.1
      expect(@camera.isValid()).to.not.be.ok
      expect(@camera.validationError[0].attr).to.equal('zoom')
