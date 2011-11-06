# Connect server
server = require('connect').createServer()
server.listen(9090)

# Redis client
redis = require('redis').createClient()

# Socket.IO
io = require('socket.io').listen(server)
io.sockets.on 'connection', (socket) ->
  socket.emit('global-messages', { type: 'annoucement', message: 'Hello' } )
  socket.on 'ikea-store1', (data) ->
    redis.sadd 'members:ikea-store1', socket.id
    redis.smembers 'members:ikea-store1', (err, replies) ->
      socket.broadcast.emit('global-messages', { type: 'roster', members: replies } )
    socket.broadcast.emit('ikea-store1', data)