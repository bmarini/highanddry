# High And Dry

This is the hackathon entry for "The Loneliest Number"

## Getting Started

Requirements:

* ruby 1.9.2 (rvm or rbenv install 1.9.2)
* bundler (gem install bundler)
* node 0.6.0 (brew install node)
* npm (curl http://npmjs.org/install.sh | sh)
* coffee-script (npm install -g coffee-script)
* redis (brew install redis)

Assuming you have redis running already, just run the following:

    bundle
    cd node && node install .
    bundle exec foreman start

Now browse to http://localhost:3000

## Technology Used

* [rails](http://guides.rails.info)
* [redis](http://redis.io)
* [coffeescript](http://jashkenas.github.com/coffee-script)
* [facebook javascript sdk](http://developers.facebook.com/docs/reference/javascript/)
* [jquery](http://jquery.com)
* [sammy](http://sammyjs.org)
