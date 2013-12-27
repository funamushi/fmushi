module.exports =
  db:
    url: process.env.HEROKU_POSTGRESQL_GRAY_URL
    define:
      freezeTableName: true

