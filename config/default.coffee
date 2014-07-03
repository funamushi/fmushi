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
      name:    '赤い虫カゴ'
      element: 'red'
      ttl:     15
    'blue-circle':
      name:    '青い虫カゴ'
      element: 'blue'
      ttl:     15

  breeds:
    'building':
      number: 1
      name: 'プー山代表取締役'
      element: 'blue'
      description: '''
大事な書類を探して世界の果てまで歩き続けてきた。なんの書類だったのか、歩き過ぎてもうよく覚えてない。あの書類さえみつかっていたら、今頃は街で一番高いビルのてっぺんで、みんなに色々なこと命令していたかもしれない。そんな思い出が頭の上に乗っている。
'''
    'boxing':
      number: 2
      name: 'ワンツーぷや夫'
      element: 'red'
      description: '''
お風呂上がりに鏡の前ですごく速いパンチができたので、ボクシングジムに入門しようと決心し、ボクシングジムを探して歩き続けている。もしかしたら、本当は闘うことが怖くてわざと違う方向へ向かっているのかもしれない。今頃は、スポットライトの当たるリングの上で歓声を浴びていたであろう、そんな思い出が頭の上に乗っている。
'''
    'tank':
      number: 3
      name: 'ヘイプー大佐'
      element: 'red'
    'cloud':
      number: 4
      name: 'プヤプヤプンヤ一等兵'
      element: 'blue'
      description: '''
何か大事な任務を遂行中に、雨が降ってきてしまった。任務を放り出すことはできない。でもお家に帰りたい。どっちを選ぶこともできなくなってしまい、どちらでもない明後日の方向に歩き続けている。もう雨は止んだはずだけど、どうも雨のことが頭から離れない。そんな思い出が頭の上に乗っかっている。
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
