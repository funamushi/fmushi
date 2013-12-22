describe Fmushi.Models.Mushi, ->
  before ->
    Fmushi.ranks = new Fmushi.Collections.Ranks [
      { id: 1, name: 'rank1' }
    ]
    Fmushi.items = new Fmushi.Collections.Items [
      { id: 1, name: 'item1' }
    ]

  describe '#set', ->
    it 'rankIdを渡すとRankモデルをプロパティにセットする', ->
      mushi = new Fmushi.Models.Mushi rankId: 1
      expect(mushi.rank).to.equal Fmushi.ranks.get(1)