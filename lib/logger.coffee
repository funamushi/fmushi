winston = require('winston')
env = process.env.NODE_ENV || "development"
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
