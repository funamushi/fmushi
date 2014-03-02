describe Fmushi.Models.Mushi, ->
  describe '#initialize', ->
    before ->
      Fmushi.ranks = new Fmushi.Collections.Ranks [
        { id: 1, name: 'rank1' }
      ]
      Fmushi.items = new Fmushi.Collections.Items [
        { id: 1, name: 'item1' }
      ]

    it 'rankIdが等しいRankモデルをプロパティに持つ', ->
      mushi = new Fmushi.Models.Mushi(rankId: 1)
      expect(mushi.rank).to.eq(Fmushi.ranks.get(1))

    it 'Equipmentsコレクションをプロパティにセットする', ->
      mushi = new Fmushi.Models.Mushi(equipments: [{id: 1}])
      expect(mushi.equipments.first().get 'id').to.equal 1

  describe 'get/set circle', ->
    beforeEach ->
      @mushi  = new Fmushi.Models.Mushi
      @circle = new Fmushi.Models.Circle(id: 100)

    it 'Circleモデルをセットすると、circleIdが更新される', ->
      @mushi.circle = @circle
      expect(@mushi.circle).to.equal(@circle)
      expect(@mushi.get 'circleId').to.equal(@circle.get 'id')
      
    it 'nullをセットすると、circleIdもnullになる', ->
      @mushi.circle = null
      expect(@mushi.circle).to.be.null
      expect(@mushi.get 'circleId').to.be.null

  describe '#set', ->
    before ->
      Fmushi.ranks = new Fmushi.Collections.Ranks [
        { id: 1, name: 'rank1' }
      ]

    beforeEach ->
      @mushi = new Fmushi.Models.Mushi

    it 'rankIdを元にRankモデルをプロパティにセットする', ->
      @mushi.set 'rankId', 1
      expect(@mushi.rank).to.equal Fmushi.ranks.get(1)

    it 'rankIdをnullにすると、Rankモデルもnullになる', ->
      @mushi.set 'rankId', null
      expect(@mushi.rank).to.be.null