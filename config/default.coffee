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
      name: 'プー山代表取締役'
      element: 'blue'
    'boxing':
      name: 'ミニマム級チャンピオン ワンツーぷや夫'
      element: 'red'
    'tank':
      name: 'ヘイプー大佐'
      element: 'red'
    'cloud':
      name: 'プヤプヤプンヤ一等兵'
      element: 'blue'
    'sakura':
      name: 'ポム家のこせがれ'
      element: 'blue'

  defaultItems:
    'red-circle':
      quantity: 2
    'blue-circle':
      quantity: 2
