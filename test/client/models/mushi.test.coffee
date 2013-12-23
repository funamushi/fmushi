describe Fmushi.Models.Mushi, ->
  before ->
    Fmushi.ranks = new Fmushi.Collections.Ranks [
      { id: 1, name: 'rank1' }
    ]
    Fmushi.items = new Fmushi.Collections.Items [
      { id: 1, name: 'item1' }
    ]

  describe '#set', ->
    beforeEach ->
      @mushi = new Fmushi.Models.Mushi

    it 'rankIdを元にRankモデルをプロパティにセットする', ->
      @mushi.set 'rankId', 1
      expect(@mushi.rank).to.equal Fmushi.ranks.get(1)

    it 'equipmentsのattributeをプロパティにセットする', ->
      @mushi.set 'equipments', [{id: 1}]
      console.log @mushi.equipments.toJSON()
      expect(@mushi.equipments.first().get('id')).to.equal 1