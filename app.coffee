express = require('express')
expose  = require('express-expose')
routes  = require('./routes')
app     = module.exports = express.createServer()

# ---------------------------------------------------------------------------
# Configuration
# ---------------------------------------------------------------------------
app.configure () ->
  app.set 'views', "#{__dirname}/views"
  app.set 'view engine', 'jade'
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static "#{__dirname}/public"

app.configure 'development', () ->
  app.use express.errorHandler({ dumpExceptions: true, showStack: true })
  app.set 'socket_url', "http://localhost:#{process.env.PORT}"

app.configure 'production', () ->
  app.use express.errorHandler()
  app.set 'socket_url', 'http://highanddry.herokuapp.com'

app.expose app.settings

# ---------------------------------------------------------------------------
# Redis client
# ---------------------------------------------------------------------------
redis = require('redis-url').connect(process.env.REDISTOGO_URL)

# ---------------------------------------------------------------------------
# Socket.IO
# ---------------------------------------------------------------------------
io = require('socket.io').listen(app)

# Heroku doesn't support websockets, lame!
io.configure () ->
  io.set("transports", ["xhr-polling"])
  io.set("polling duration", 10)

io.sockets.on 'connection', (socket) ->
  socket.on 'set nickname', (data) ->
    socket.set('nickname', data.nickname)

  socket.on 'ikea-store1', (data) ->
    redis.sadd 'members:ikea-store1', socket.id
    redis.smembers 'members:ikea-store1', (err, replies) ->
      socket.broadcast.emit('global-messages', { type: 'roster', members: replies } )

    socket.get 'nickname', (err, name) ->
      data['name'] = name
      socket.broadcast.emit('ikea-store1', data)

    socket.emit 'ikea-store1', { message: "#{data.message} yourself!" }

# ---------------------------------------------------------------------------
# Routes
# ---------------------------------------------------------------------------
app.get '/', routes.index

# {"FBid":" 100002193978966","Name":"Some trucker ","Direction":"San Francisco","PayLoad":"Furniture","Compensation":10}
app.post '/riders', (req, res) ->
  rider = req.body
  redis.sadd "riders", rider.Fbid
  redis.hset rider.Fbid, "Name", rider.Name
  redis.hset rider.Fbid, "Direction", rider.Direction
  redis.hset rider.Fbid, "PayLoad", rider.PayLoad
  redis.hset rider.Fbid, "Compensation", rider.Compensation
  redis.expire rider.Fbid, (60 * 60)
  res.json(rider, 201)

app.listen( process.env.PORT || 5000 )
console.log("Express server listening on port %d in %s mode", app.address().port, app.settings.env)

