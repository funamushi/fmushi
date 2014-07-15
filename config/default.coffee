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
      name: 'プー山社長'
      element: 'blue'
      description: '''
大事な書類を探して世界の果てまで歩き続けている。歩き過ぎてなんの書類だったのかよく思い出せないけど。あの書類さえみつかったら、ビジネスが成功して、今頃は街で一番高いビルのてっぺんで、みんなに色々なことを命令していたかもしれない。そんな思い出が頭の上に乗っている。
'''
    'boxing':
      number: 2
      name: 'ワンツーぷや夫'
      element: 'red'
      description: '''
お風呂上がりに鏡の前ですごく速いパンチができたので、ボクシングジムに入門しようと決心し、ボクシングジムを探して歩き続けている。もしかしたら、本当は闘うことが怖くてわざと違う方向へ向かっているのかもしれない。もしも歩く方向が違っていたら今頃は、スポットライトの当たるリングの上で歓声を浴びていたはずだと思い込んでいる。
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
