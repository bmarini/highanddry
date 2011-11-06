(($) ->
  # Init Socket.IO
  socket = io.connect 'http://localhost:9090'

  appendMessage = (name, message) ->
      $("#chatroom").append("<b>#{name}</b> ") if name
      $("#chatroom").append(message).append("<br>")

  # Set up routes
  app = $.sammy () ->
    @get '#/', (context) ->
      context.log 'Here we go!'

      # Subscribe to a global message channel
      socket.on "global-messages", (data) ->
        context.log data

      # Subscribe to an ikea store channel
      socket.on "ikea-store1", (data) ->
        appendMessage(data.name, data.message)

      # Publish messages to the ikea channel
      $("#message-form").submit () ->
        appendMessage( $("#nickname").val(), $("#message").val() )
        socket.emit 'set nickname', { nickname: $("#nickname").val() }
        socket.emit 'ikea-store1', { message: $("#message").val() }
        $("#message").val("")
        return false

  # Kick things off
  $ ()->
    app.run '#/'

)(jQuery)
