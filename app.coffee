# module
express = require 'express'
http = require 'http'
path = require 'path'

app = express()

app.configure ->
  app.set 'port', process.env.PORT || 3000
  app.use express.logger 'dev'
  app.use express.methodOverride()

app.configure 'development', ->
  app.use express.errorHandler()

http.createServer(app).listen app.get('port'), ->
  console.log "Express server listening on port #{app.get('port')}"

# application
twitter = require 'twitter'
cronJob = require('cron').CronJob

# time cycle
cronTime = '*/1 * * * *'
count = 1

# instance
bot = new twitter
	consumer_key:'your_consumer_key',
	consumer_secret:'your_consumer_secret',
	access_token_key:'your_access_token',
	access_token_secret:'your_access_token_secret'


job = new cronJob
	cronTime: cronTime
	, onTick: ->
		console.log 'function'
		bot.updateStatus "test #{count++} #test", (data) ->
			console.log count
			job.stop() if count is 10
	, onComplete: ->
		console.log 'complete'
	, start: false


# Runs job.
job.start()
