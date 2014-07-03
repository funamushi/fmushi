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
    'boxing':
      number: 2
      name: 'ワンツーぷや夫'
      element: 'red'
      description: '''
お風呂上がりに鏡の前でワンツーパンチをしてみたら、すごく速いパンチができたので、ボクシングに入門したけど、最初の一日目にぶよぶよのおなかをパンチされて嫌になってしまい、ここまで歩いてきた。あのとき続けていれば、今頃はスポットライトの当たるリングの上で歓声を浴びていたかもしれない。そんな思い出が頭の上に乗っています。
'''
    'tank':
      number: 3
      name: 'ヘイプー大佐'
      element: 'red'
    'cloud':
      number: 4
      name: 'プヤプヤプンヤ一等兵'
      element: 'blue'
    'sakura':
      number: 5
      name: 'ポム家のこせがれ'
      element: 'red'
      description: '''
東京に憧れて、ずっとここまで歩き続けてきた。本当は東京はこっちの方向にはないことはそろそろ気づき始めているけど、あまりにも長い間歩いてきたので、なかなかそのことを認めようとせず、まだまだ間違った方角に進み続けている。故郷の大自然は、住んでるときは退屈だったけど、たまに思い出すと落ち着くので、故郷の景色の思い出が頭の上に乗っています。
'''

  defaultItems:
    'red-circle': 4
    'blue-circle': 4
