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
      name: '赤いカプセル'
      element: 'red'
    'blue-circle':
      name: '青いカプセル'
      element: 'blue'

  breeds:
    'building':
      name: 'プヤプヤプンヤ代表取締役'
      element: 'blue'
    'boxing':
      name: 'ミニマム級チャンピオン ワンツーぷや夫'
      element: 'red'
    'umbrella':
      name: 'ヘイプー大佐'
      element: 'red'

  defaultItems: [
    'red-circle'
  ]
