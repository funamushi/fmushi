winston = require('winston')

module.exports = logger = new winston.Logger(
  transports: [
      new winston.transports.Console(
            handleExceptions: true
            timestamp: true
            colorize: true
          )
    ],
  exitOnError: false
)
