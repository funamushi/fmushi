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
      name: '遠赤外線さみしくなんかないカプセル'
      element: 'red'
    'blue-circle':
      name: '本当は一人ぼっち酸素カプセル'
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