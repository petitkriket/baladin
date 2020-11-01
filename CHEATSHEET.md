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
