(function() {
  var Facebook;
  Facebook = (function() {
    function Facebook() {}
    Facebook.prototype.login = function() {
      return FB.login(function(response) {
        if (response.authResponse) {
          console.log('Welcome!  Fetching your information.... ');
          return FB.api('/me', function(response) {
            console.log("Good to see you " + response.name);
            return FB.logout(function(response) {
              return console.log('Logged out.');
            });
          });
        } else {
          return console.log('User cancelled login or did not fully authorize.');
        }
      }, {
        scope: 'email'
      });
    };
    return Facebook;
  })();
  this.Facebook = new Facebook;
}).call(this);
