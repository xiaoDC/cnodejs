fs     = require 'fs'
config = require '../config'

unless fs.existsSync('./log')
  fs.mkdirSync './log'

exports.log = ->
  writeLog '', 'info', arguments

exports.info = ->
  writeLog '  ', 'info', arguments

exports.debug = ->
  writeLog '  ', 'debug', arguments

exports.warn = ->
  writeLog '  ', 'warn', arguments

exports.error = ->
  writeLog '  ', 'error', arguments

env = process.env.NODE_ENV || "development"
consolePrint = config.debug && env isnt 'dev'
writeLog = (prefix, logType, args) ->
  filePrint = logType isnt 'debug'

  unless filePrint or consolePrint
    return

  infos = Array.prototype.slice.call args

  logStr = infos.join ' '

  switch logType
    when 'debug'
      logStr = logStr.gray
      break
    when 'earn'
      logStr = logStr.yellow
      break
    when 'error'
      logStr = logStr.red
      break
  line = prefix + logStr

  if filePrint
    fs.appendFile "./log/#{env}.log", "#{line}\n"
  if consolePrint
    console.log line