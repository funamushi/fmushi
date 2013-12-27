F虫
=========

[![Build Status](https://travis-ci.org/funamushi/fmushi.png?branch=master)](https://travis-ci.org/funamushi/fmushi)

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

## でーたべーす
```
createdb DB名
createuser ユーザ名
alter database DB名 owner to ユーザ名
```

## とすて

```bash
$ npm test
```

## デプロイ

```bash
$ bundle exec cap staging deploy
```

### issueとか
https://bitbucket.org/funamushi/fmushi
