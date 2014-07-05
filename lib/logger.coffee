winston = require('winston')
logLevel = require('config').logLevel

module.exports = logger = new winston.Logger(
  transports: [
      new winston.transports.Console(
            handleExceptions: true
            timestamp: true
            colorize: true
            level: logLevel
          )
    ],
  exitOnError: false
)
