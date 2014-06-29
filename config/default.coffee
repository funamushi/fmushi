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
      name:    '水冷式 嫌いな気持ち冷まし機'
      element: 'red'
      ttl:     10
    'blue-circle':
      name:    '遠赤外線 さみしくない装置'
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
      element: 'red'

  defaultItems:
    'red-circle': 2
    'blue-circle': 2
