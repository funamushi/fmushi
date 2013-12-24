describe Fmushi.Models.Equipment, ->
  describe '#set', ->
    before ->
      Fmushi.items = new Fmushi.Collections.Items [
        { id: 1, name: 'item1' }
      ]

    beforeEach ->
      @equipment = new Fmushi.Models.Equipment

    it 'rankIdを元にRankモデルをプロパティにセットする', ->
      @equipment.set 'itemId', 1
      expect(@equipment.item).to.equal Fmushi.items.get(1)

    