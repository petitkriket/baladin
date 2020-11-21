
The Passengers
================
-------------

This application requires:

- Postgres
- Ruby 2.6.5
- Rails 5.2.0

Learn more about [Installing Rails](http://railsapps.github.io/installing-rails.html).

Getting Started
---------------

Installation :

```shell
$ rbenv local 2.6.5
$ exec bundle install
$ yarn install
```

Create and fill database

```shell
$ psql -U postgres
  create role pssgrs with createdb login password 'pssgrs';
  ALTER USER pssgrs WITH SUPERUSER;
  \q

$ rake db:setup
```

Start the app API and Webpack

```shell
$ rails s
$ ./bin/webpack-dev-server
```

Contributing
------------

Credits
-------

License
-------

cc-by-sa-4.0
