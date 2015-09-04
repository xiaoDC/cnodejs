config = require './config'

unless config.debug
  require 'newrelic'

require('colors')
path = require 'path'
express = require 'express'
session = require 'express-session'
passport = require 'passport'