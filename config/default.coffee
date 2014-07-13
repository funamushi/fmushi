module.exports =
  elements:
    red:
      name: '大嫌い'
      prev: 'blue'
      next: 'blue'
      inverse: 'blue'
    blue:
      name: 'さみしい'
      prev: 'red'
      next: 'red'
      inverse: 'red'

  items:
    'red-circle':
      name:    '大嫌い虫カゴ'
      element: 'red'
      ttl:     15
    'blue-circle':
      name:    'さみしい虫カゴ'
      element: 'blue'
      ttl:     15

  breeds:
    'building':
      number: 1
      name: 'プー山代表取締役'
      element: 'blue'
      description: '''
大事な書類を探している。歩き過ぎて詳しいことは思い出せないけど、あの書類さえみつかったら、ビジネスが成功して、今頃は街で一番高いビルのてっぺんで、みんなに色々な命令を下していたはず。
'''
    'boxing':
      number: 2
      name: 'ワンツーぷや夫'
      element: 'red'
      description: '''
入門するためボクシングジムボクシングジムを探して歩き続けている。もしかすると、闘うことが怖いからわざとボクシングジムがない方向へ歩いている気もしている。歩く方向によっては今頃は、スポットライトの当たるリングの上で歓声を浴びていたはず。。
'''
    'tank':
      number: 3
      name: 'ヘイプー大佐'
      element: 'red'
      description: '''
一人しかいない部下とはぐれてしまったので探しに来た。部下と一緒に戦車に乗った時の思い出が頭の上に乗っている。
'''
    'cloud':
      number: 4
      name: 'プヤプヤプンヤ一等兵'
      element: 'blue'
      description: '''
知らない国での、何かとても大事な任務を遂行中、雨が降っきたため、家に帰りたい気持ちになってしまった。かといって、任務を放り出すことはできず、どちらともつかない明後日の方向へ向かって歩いている。
'''
    'sakura':
      number: 5
      name: 'ポム家のこせがれ'
      element: 'red'
      description: '''
東京に憧れて、ずっとここまで歩き続けてきた。本当は東京はこっちの方向にはないことはそろそろ気づき始めているけど、あまりにも長い間歩いてきたので、なかなかそのことを認めようとせず、まだまだ間違った方角に進み続けている。
最近は東京のことはあまり考えない。故郷の景色の思い出が頭の上に乗っている。
'''

  defaultItems:
    'red-circle': 4
    'blue-circle': 4
