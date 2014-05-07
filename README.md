F虫
=========


[![Build Status](https://travis-ci.org/funamushi/fmushi.png?branch=master)](https://travis-ci.org/funamushi/fmushi)
## 開発環境

```bash
$ npm install -g brunch
$ npm install -g bower
$ npm install -g supervisor
$ npm install -g coffee-script
```

```bash
$ git clone git@github.com:funamushi/fmushi.git
$ cd fmushi
$ npm install
$ brunch w -s
```

## でーたべ

```bash
$ createuser fmushi
$ createdb -O fmushi fmushi_development
```

### マイグレ

```bash
$ ./node_modules/.bin/sequelize -m --coffee
```

### マスタデータ

```bash
$ coffee seeds.coffee
```

## とすて

```bash
$ npm test
```

or

### サーバサイド

```bash
$ mocha test/server/path/to/file
```

### クライアントサイド

```bash
$ karma start karma.coffee
```

## へろく

```bash
$ git push heroku master
```

### issueとか

https://bitbucket.org/funamushi/fmushi
