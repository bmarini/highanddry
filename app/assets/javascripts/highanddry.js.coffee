(($) ->
  # Init Socket.IO
  socket = io.connect 'http://localhost:9090'

  # Set up routes
  app = $.sammy () ->
    @get '#/', (context) ->
      context.log 'Here we go!'

      # Subscribe to a global message channel
      socket.on "global-messages", (data) ->
        context.log data

      # Subscribe to an ikea store channel
      socket.on "ikea-store1", (data) ->
        $("#chatroom").append("<b>#{data.name}</b> ") if data.name
        $("#chatroom").append(data.message).append("<br>")

      # Publish messages to the ikea channel
      $("#message-form").submit () ->
        $("#chatroom").append( $("#message").val() ).append("<br>")
        socket.emit 'ikea-store1', { message: $("#message").val() }
        $("#message").val("")
        return false

      $("#nickname-form").submit () ->
        socket.emit 'set nickname', { nickname: $("#nickname").val() }
        return false

  # Kick things off
  $ ()->
    app.run '#/'

)(jQuery)
