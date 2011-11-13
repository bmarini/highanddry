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
    app = $.sammy('#content', function() {
      this.use('Mustache');
      this.swap = function(content) {
        var el;
        el = this.$element();
        return el.fadeOut(function() {
          return el.html(content).fadeIn();
        });
      };
      this.get('#/', function(context) {
        return context.log('Here we go!');
      });
      this.get('#/needalift', function(context) {
        return context.render('needalift.mustache', {}).swap();
      });
      this.get('#/chatroom', function(context) {
        context.render('chatroom.mustache', {}).swap();
        socket.on("global-messages", function(data) {
          return context.log(data);
        });
        return socket.on("ikea-store1", function(data) {
          return appendMessage(data.name, data.message);
        });
      });
      return this.get('#/chatroom/message', function(context) {
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
    return $(function() {
      return app.run('#/');
    });
  })(jQuery);
}).call(this);
