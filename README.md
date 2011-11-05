# High And Dry

This is the hackathon entry for "The Loneliest Number"

## Getting Started

Requirements:

* ruby 1.9.2 (rvm or rbenv install 1.9.2)
* juggernaut (npm install -g juggernaut)
* redis (brew install redis)

Assuming you have redis running already, just run the following:

    bundle
    foreman start

Now browse to http://localhost:3000

The browser is subscribed to receive messages on the channel "global-messages"
and will log them to the firebug console. You can play with it by opening up
the Rails app on the console and sending messages, like this:

    rails console
    > Juggernaut.publish "global-messages", :my => "object", :becomes => "a json obj on the browser"

## Technology Used

* [rails](http://guides.rails.info)
* [redis](http://redis.io)
* [juggernaut](https://github.com/maccman/juggernaut)
* [coffeescript](http://jashkenas.github.com/coffee-script)
* [facebook javascript sdk](http://developers.facebook.com/docs/reference/javascript/)
* [jquery](http://jquery.com)
* [sammy](http://sammyjs.org)