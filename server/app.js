"use strict";

let koa = require('koa');
let app = koa();
let hbs = require('koa-hbs');
let serve = require('koa-static');

app.use(serve('public'));

app.use(hbs.middleware({
  viewPath: `${__dirname}/views`
}));

app.use(function *() {
  yield this.render('index', { 'title': 'F虫' });
});

app.listen(3000);
