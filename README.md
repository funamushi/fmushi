F虫
=========

[![Build Status](https://drone.io/github.com/funamushi/fmushi/status.png)](https://drone.io/github.com/funamushi/fmushi/latest)
## 開発環境

```bash
$ npm install -g brunch
$ npm install -g bower
```

```bash
$ git clone git@github.com:funamushi/fmushi.git
$ cd fmushi
$ npm install
$ brunch w -s
```

## でーたべ
```
createuser fmushi
createdb -O fmushi fmushi_development
```

## マイグレ
```
sequelize -m --coffee
```

## とすて

```bash
$ npm test
```

or

```bash
$ mocha path/to/file
```

## へろく

```bash
$ git push heroku master
```

### issueとか
https://bitbucket.org/funamushi/fmushi
