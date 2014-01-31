module.exports = db = {}

db[process.env.NODE_ENV] = require('./config').db
