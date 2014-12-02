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
      name: 'ヘイプー大佐'
      element: 'blue'
      description: '''
'''
    'boxing':
      number: 2
      name: 'ワンツーぷや夫'
      element: 'red'
      description: '''
'''
    'tank':
      number: 3
      name: 'プヤプヤプンヤ一等兵'
      element: 'red'
      description: '''
'''
    'cloud':
      number: 4
      name: 'ぷちゃ夫'
      element: 'blue'
      description: '''
'''
    'sakura':
      number: 5
      name: 'ポム家のこせがれ'
      element: 'red'
      description: '''
'''

  defaultItems:
    'red-circle': 4
    'blue-circle': 4
