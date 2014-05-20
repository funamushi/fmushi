module.exports =
  elements:
    red:
      name: '大嫌い'
      inverseName: 'さみしくない'
      prev: 'blue'
      next: 'blue'
    blue:
      name: 'さみしい'
      inverseName: '好き'
      prev: 'red'
      next: 'red'

  items:
    'red-circle':
      name: '遠赤外線さみしくないカプセル'
      element: 'red'
    'blue-circle':
      name: '???'
      element: 'blue'
    'green-circle':
      name: '???'
      element: 'green'

  breeds:
    'building':
      name: 'プヤプヤプンヤ代表取締役'
      element: 'blue'
    'boxing':
      name: 'ミニマム級チャンピオン ワンツーぷや夫'
      element: 'red'
    'umbrella':
      name: 'ヘイプー大佐'
      element: 'green'

  defaultItems: [
    'red-circle'
  ]