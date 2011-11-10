# id: 276947125676817
# secret: 78878218a8a14e71fe1f3cd6ef3a7ba9

class Facebook
  constructor: () ->
  login: () ->
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

  handleStatusChange: (response) ->
    document.body.className = response.authResponse ? 'connected' : 'not-connected'
    console.log(response) if response.authResponse

this.Facebook = new Facebook
