(function() {
  (function($) {
    var app, appendMessage, socket;
    socket = io.connect('http://localhost:5000');
    appendMessage = function(name, message) {
      if (name) {
        $("#chatroom").append("<b>" + name + "</b> ");
      }
      return $("#chatroom").append(message).append("<br>");
    };
    app = $.sammy(function() {
      return this.get('#/', function(context) {
        context.log('Here we go!');
        socket.on("global-messages", function(data) {
          return context.log(data);
        });
        socket.on("ikea-store1", function(data) {
          return appendMessage(data.name, data.message);
        });
        return $("#message-form").submit(function() {
          appendMessage($("#nickname").val(), $("#message").val());
          socket.emit('set nickname', {
            nickname: $("#nickname").val()
          });
          socket.emit('ikea-store1', {
            message: $("#message").val()
          });
          $("#message").val("");
          return false;
        });
      });
    });
    return $(function() {
      return app.run('#/');
    });
  })(jQuery);
}).call(this);
