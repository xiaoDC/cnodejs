mongoose = require 'mongoose'
logger   = require '../common/logger'

traceMQuery = (method, info, query) ->
  (err, result, millis) ->
    infos = []
    infos.push "#{query._collection.collection.name}.#{method.blue}"
    infos.push JSON.stringify(info)
    infos.push ("#{millis}ms").green

    logger.debug "MONGO".magenta, infos.join(' ')

mongoose.Mongoose.prototype.mquery.setGlobalTraceFunction traceMQuery