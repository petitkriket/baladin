# Useful commands

## Env stuff

$ rbenv version
$ rbenv local 0.0.0
$ rbenv global 0.0.0
$ rbenv rehash

## Database stuff

$ rbenv exec rails db:create
$ rbenv exec rails db:migrate
$ rbenv exec rails db:drop
$ rbenv exec rails db:seed
$ rbenv exec rails s

## Updating a project

update Rubygems
$ gem update --system

update bundler
$ gem install bundler

update Gemfile.lock in your project
$ bundler update --bundler

## Add or update gems

$ bundle update
$ bundle update carrierwave
$ bundle install # after adding gem to gemfile

## Fetch a S3 bucket

$ brew install awscli
$ aws configure
$ aws s3 sync s3://bucket-name destination/folder

## Production to staging

1. Get database colors (here DATABASE_URL)
$ heroku pg:info -a pssgrsv2
$ heroku pg:info -a pssgrsv2-staging

2. Copy first database to the other
$ heroku pg:copy appname-production::WHITE_ORIGIN_URL GOLD_DEST_DATABASE_URL -a appname-staging
$ heroku pg:copy pssgrsv2::DATABASE_URL DATABASE_URL -a pssgrsv2-staging --confirm pssgrsv2-staging

## Connect to an app shell

Here to resent confirmation instructions

```bash
$ heroku run rails c -a pssgrsv2-pr-1)
> c = User.last
> c.send_confirmation_instructions
```

## Remove secrets from git

$ git filter-branch --index-filter "git rm -rf --cached --ignore-unmatch path_to_file" HEAD

## Useful gems

- Bullet [git](https://github.com/flyerhzm/bullet) to kill n+1.
- Letter Opener [git](https://github.com/fgrehm/letter_opener_web) to catch e-mails.

## Setup tests and fixtures

- [Setup](https://gist.github.com/sharvy/d63fbcb18489bef773b82c992583a972)
- [Setup 2](https://bintlopez.gitbooks.io/rspec-wrangling/content/part-1/factory-bot-faker-setup.html)
- [Sign in with Devise](https://github.com/heartcombo/devise/wiki/How-To:-sign-in-and-out-a-user-in-Request-type-specs-(specs-tagged-with-type:-:request))
- [Testing emails](https://www.lucascaton.com.br/2010/10/25/how-to-test-mailers-in-rails-with-rspec/)
- [Emails and jobs](https://coderwall.com/p/xqcq7q/how-to-test-actionmailer-activejob-with-rspec)

## JWT Authentification

- [devise-jwt](https://github.com/waiting-for-dev/devise-jwt)
- [Help 1](https://jameschambers.co.uk/rails-api)
- [Help 2](hthttps://adamnaamani.com/jwt-authentication-with-warden-and-devise/)
- [Help 3](https://medium.com/@mazik.wyry/rails-5-api-jwt-setup-in-minutes-using-devise-71670fd4ed03)
- [302 redirect](https://groups.google.com/g/plataformatec-devise/c/XUkVIqq2Rgc)

## Vue3 and tooling

- [BLOCKER HEROKU](https://stackoverflow.com/a/58631557/3468846)
- [BLOCKER HMR](https://github.com/rails/rails/issues/31754#issuecomment-359281145)
- [vue3](https://dev.to/vannsl/vue3-on-rails-l9d)
- [bunldle analyzer](https://razorjack.net/visualizing-optimizing-javascript-bundle-size-rails-webpacker/)
- [stylelint](https://medium.com/haiiro-io/stylelint-b67ab2b8e690)
- [storybook pr](https://github.com/liip/chusho/pull/54)
- [other libs](https://github.com/vuejs/awesome-vue/issues/3544)

## Common packages

- [vue-i18n advanced patterns](https://blog.logrocket.com/advanced-localization-techniques-vue-js/)
- [vuex store using constants](https://medium.com/@rijk/make-your-vuex-mutation-names-friendly-7e4b53597cd0)

```bash
$ rails s
$ ./bin/webpack-dev-server
$ yarn run webpack:analyze
```

### Mapbox + Leaflet
- [use mapbox tile with vue2leaflet](https://gist.github.com/timwis/eb2c7824bc8dca1727bd1bd96ecf24f0)
- [csp rules](https://github.com/mapbox/mapbox-gl-js/issues/4788#issuecomment-306467312)
-   [weird js error](https://github.com/mapbox/mapbox-gl-js/issues/3422#issuecomment-577293154)
