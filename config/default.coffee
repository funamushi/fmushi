module.exports =
  elements:
    red:
      name: '大嫌い'
      prev: 'blue'
      next: 'blue'
    blue:
      name: 'さみしい'
      prev: 'red'
      next: 'red'

  items:
    'red-circle':
      name:    '赤い虫カゴ'
      element: 'red'
      ttl:     10
    'blue-circle':
      name:    '青い虫カゴ'
      element: 'blue'
      ttl:     10

  breeds:
    'building':
      number: 1
      name: 'プー山代表取締役'
      element: 'blue'
    'boxing':
      number: 2
      name: 'ミニマム級チャンピオン ワンツーぷや夫'
      element: 'red'
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
      element: 'blue'

  defaultItems:
    'red-circle': 2
    'blue-circle': 2
