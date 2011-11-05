class Facebook
  constructor: () ->
  login: ->
    FB.login (response) ->
      if response.authResponse
        console.log 'Welcome!  Fetching your information.... '
        FB.api '/me', (response) ->
          console.log "Good to see you #{response.name}"
          FB.logout (response) ->
            console.log 'Logged out.'
      else
        console.log 'User cancelled login or did not fully authorize.'
    , { scope: 'email' }

this.Facebook = new Facebook
