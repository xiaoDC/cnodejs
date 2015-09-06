express = require 'express'
site    = require './controllers/site'
router  = express.Router()
router.get '/', site.index

module.exports = router