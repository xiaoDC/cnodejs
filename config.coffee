path = require 'path'

config =
  debug             : true

  name              : 'Nodeclub'
  description       : 'CNode: Node.js 专业中文社区'

  # 添加到 html head 中的信息
  site_headers      : [
    '<meta name       ="author" content="chenglong01020@gmail.com">'
  ]

  site_static_host  : ''
  host              : 'localhost'
  google_tracker_id : ''

  # mongodb 配置
  db                : 'mongodb://127.0.0.1/node_club_dev'

  # redis 配置，默认是本地
  redis_host        : '127.0.0.1'
  redis_port        : 6379
  redis_db          : 0

  session_secret    : 'cl_club_secret'

  # 程序运行的端口
  port              : 3000

if process.env.NODE_ENV is 'development'
  config.db = 'mongodb://127.0.0.1/node_club_dev'


module.exports = config