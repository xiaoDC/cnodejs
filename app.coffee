config = require './config'

unless config.debug
  require 'newrelic'

require 'colors'
require './middlewares/mongoose_log'
# require './models'
path       = require 'path'
Loader     = require 'loader'
express    = require 'express'
session    = require 'express-session'
passport   = require 'passport'
RedisStore = require 'connect-redis'
helmet     = require 'helmet'
csurf      = require 'csurf'
compress   = require 'compression'
bodyParser = require 'body-parser'
logger     = require './common/logger'
webRouter  = require './web_router'

# 静态文件目录
staticDir       = path.join __dirname, 'public'
assets          = {}

urlinfo         = require('url').parse(config.host)
config.hostname = urlinfo.hostname || config.host

# configuration in all env
app = express()
app.set 'views', path.join(__dirname, 'views')
app.set 'view engine', 'html'
app.engine 'html', require('ejs-mate')

# 静态资源
app.use Loader.less(__dirname)
app.use '/public', express.static(staticDir)

# 通用的中间件
app.use require('response-time')()
app.use helmet.frameguard('sameorigin')
app.use bodyParser.json({limit: '1mb'})
app.use bodyParser.urlencoded({ extended: true, limit: '1mb' })
app.use require('method-override')()
app.use require('cookie-parser')(config.session_secret)
app.use compress()

# routes
app.use '/', webRouter

# error handler
app.use (err, req, res, next) ->
  console.error 'server 500 error:', err
  res.status(500).send('500 status')

app.listen config.port, ->
  logger.log 'NodeClub listening on port', config.port
  logger.log 'God bless love....'
  logger.log "You can debug your app with http://#{config.hostname}:#{config.port}"
  logger.log ''
