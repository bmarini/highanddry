(($) ->
  # Init Juggernaut
  jug = new Juggernaut

  # Set up routes
  app = $.sammy () ->
    @get '#/', (context) ->
      context.log('Here we go!')
      jug.subscribe "global-messages", (data) ->
        context.log(data)

  # Kick things off
  $ ()->
    app.run '#/'

)(jQuery)
