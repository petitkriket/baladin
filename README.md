Pssgrs
================

[![Deploy to Heroku](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

This application was generated with the [rails_apps_composer](https://github.com/RailsApps/rails_apps_composer) gem
provided by the [RailsApps Project](http://railsapps.github.io/).

Rails Composer is supported by developers who purchase our RailsApps tutorials.

Problems? Issues?
-----------

Need help? Ask on Stack Overflow with the tag 'railsapps.'

Your application contains diagnostics in the README file. Please provide a copy of the README file when reporting any issues.

If the application doesn't work as expected, please [report an issue](https://github.com/RailsApps/rails_apps_composer/issues)
and include the diagnostics.

Ruby on Rails
-------------

This application requires:

- Ruby 2.4.1
- Rails 5.2.0

Learn more about [Installing Rails](http://railsapps.github.io/installing-rails.html).

Getting Started
---------------

Documentation and Support
-------------------------

Issues
-------------

Similar Projects
----------------

Contributing
------------

Credits
-------

License
-------

Variables
-------
heroku config:set DOMAIN_NAME=pssgrs.com
heroku config:set GMAIL_USERNAME=bouaroua.samuel@gmail.com
heroku config:set GMAIL_PASSWORD=jcinrwyelnhtvkwc
#config figaro, poser toutes les variables du fichier cfg
figaro heroku:set -e production
heroku rake db:migrate

Tools
-------
heroku logs -t


rails g devise:views

rails g scaffold Passenger name:string photo:string shortcut:string token:string

rails g scaffold Event address:string city:string country:string latitude:float longitude:float photo:string passenger:references user:references published:boolean
