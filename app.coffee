# Connect server
connect = require('connect')
server  = connect.createServer()
port    = process.env.PORT || 9090

server.use connect.static( "#{__dirname}/public" )
server.listen(port)

# Redis client
redis = require('redis').createClient()

# Socket.IO
io = require('socket.io').listen(server)
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
