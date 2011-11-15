(($) ->
  $ ()->
    # Init Socket.IO
    socket = io.connect express.socket_url

    appendMessage = (name, message) ->
        $("#chatroom").append("<b>#{name}</b> ") if name
        $("#chatroom").append(message).append("<br>")

    # Set up routes
    app = $.sammy '#content', () ->
      @use('Mustache')

      @swap = (content) ->
        el = this.$element()
        el.fadeOut () -> el.html(content).fadeIn()

      @get '#/', (context) ->
        context.log 'Here we go!'

      @get '#/needalift', (context) ->
        context.render('needalift.mustache', {}).swap()

      @get '#/chatroom', (context) ->
        context.render('chatroom.mustache', {}).swap()

        # Subscribe to a global message channel
        socket.on "global-messages", (data) ->
          context.log data

        # Subscribe to an ikea store channel
        socket.on "ikea-store1", (data) ->
          appendMessage(data.name, data.message)

      @post '#/chatroom/message', (context) ->
        # Publish messages to the ikea channel
        appendMessage( $("#nickname").val(), $("#message").val() )
        socket.emit 'set nickname', { nickname: $("#nickname").val() }
        socket.emit 'ikea-store1', { message: $("#message").val() }
        $("#message").val("")
        return false

    # Kick things off
    app.run '#/'

)(jQuery)
