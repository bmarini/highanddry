# High And Dry

This is the hackathon entry for "The Loneliest Number"

## Getting Started

Requirements:

* ruby 1.9.2 (rvm or rbenv install 1.9.2)
* node 0.4.x (brew install node)
* npm (curl http://npmjs.org/install.sh | sh)
* coffee-script (npm install -g coffee-script)
* redis (brew install redis)

Assuming you have redis running already, just run the following:

    gem install foreman
    gem install sass
    gem install coffee-script
    cd node && npm install .
    cd ..
    bundle exec foreman start -f Procfile.dev
    bundle exec foreman start (in a seperate terminal)

Now browse to http://localhost:5000

## Technology Used

* [redis](http://redis.io)
* [coffeescript](http://jashkenas.github.com/coffee-script)
* [facebook javascript sdk](http://developers.facebook.com/docs/reference/javascript/)
* [jquery](http://jquery.com)
* [sammy](http://sammyjs.org)
