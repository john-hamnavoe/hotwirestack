# Overview

This README would normally document whatever steps are necessary to get the
application up and running.

## Create a new Rails app

```
rails new hotwirestack -d postgresql --css=tailwind --javascript=esbuild
```


### Setup database.yml

```
development:
  primary:
    <<: *default
    database: hotwirestack_development
  cache:
    <<: *default
    database: hotwirestack_development_cache
    migrations_paths: db/cache_migrate

production:
  primary: &primary_production
    <<: *default
    database: hotwirestack_production
    username: hotwirestack
    password: <%= ENV["HOTWIRESTACK_DATABASE_PASSWORD"] %>
  cache:
    <<: *primary_production
    database: hotwirestack_production_cache
    url: <%= ENV["CACHE_DATABASE_URL"] %>
    migrations_paths: db/cache_migrate
  queue:
    <<: *primary_production
    database: hotwirestack_production_queue
    url: <%= ENV["QUEUE_DATABASE_URL"] %>
    migrations_paths: db/queue_migrate
  cable:
    <<: *primary_production
    database: hotwirestack_production_cable
    url: <%= ENV["CABLE_DATABASE_URL"] %>
    migrations_paths: db/cable_migrate
```

### Development Databases 
```
rails db:create
rails db:migrate
rails db:create:cache
rails db:migrate:cache
```


## Git Setup

```
git init
git add .
git commit -m "Initial commit"
```

Create a new repository on GitHub and push your local repository to it.

```
git remote add origin https://github.com/john-hamnavoe/hotwirestack.git
git branch -M main
git push -u origin main
```


## Hatchbox 

Create a new Hatchbox project and create 4 postgresql databases. Suffix each with _main, _cache, _queue, and _cable.

It will create new environment variables for you to use in your app, rename them as follows:

```
CACHE_DATABASE_URL=
QUEUE_DATABASE_URL=
CABLE_DATABASE_URL=
```

Update the post deploy scripts to add (you on main app page use Edit option): 

```
bundle exec rails db:migrate:cable 
bundle exec rails db:migrate:cache
bundle exec rails db:migrate:queue
```
