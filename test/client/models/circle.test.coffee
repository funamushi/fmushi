describe Fmushi.Models.Circle, ->
  describe '#entityCount', ->
    beforeEach ->
      @circle = new Fmushi.Models.Circle

    it 'デフォルトは0', ->
      expect(@circle.entityCount()).to.equal 0

    it 'entityを追加すると1増加する', ->
      @circle.addEntity new Fmushi.Models.Mushi
      expect(@circle.entityCount()).to.equal 1

    it 'entityを削除すると1減る', ->
      mushi = new Fmushi.Models.Mushi
      @circle.addEntity mushi
      expect(@circle.entityCount()).to.equal 1
      @circle.removeEntity mushi
      expect(@circle.entityCount()).to.equal 0

  describe '#addEntity', ->
    beforeEach ->
      @circle = new Fmushi.Models.Circle id: 1
      @mushi  = new Fmushi.Models.Mushi

    it 'entityのcircleIdを更新する', ->
      expect(@mushi.get('circleId')).to.be.undefined
      @circle.addEntity @mushi
      expect(@mushi.get('circleId')).to.equal 1

    it 'circle:addイベントを発火する', (done) ->
      @circle.on 'circle:add', ->
        done()
      @circle.addEntity @mushi

  describe '#removeEntity', ->
    beforeEach ->
      @circle = new Fmushi.Models.Circle id: 1
      @mushi  = new Fmushi.Models.Mushi
      @circle.addEntity @mushi

    it 'entityのcircleIdをnullにする', ->
      expect(@mushi.get('circleId')).to.equal 1
      @circle.removeEntity @mushi
      expect(@mushi.get('circleId')).to.be.null

    it 'circle:removeイベントを発火する', (done) ->
      @circle.on 'circle:remove', ->
        done()
      @circle.removeEntity @mushi
