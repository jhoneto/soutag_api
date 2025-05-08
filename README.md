# README

## Getting Started

Install Ruby 3.4.1 and Bundler.

Create database and run migrations.

```
bundle install
bundle exec rails db:create
bundle exec rails db:migrate
```

Run the server.

```
bundle exec rails server
```

## Seeding

Create a user and a gas station.

```
bin/rails db:seed
```

## Testing

Run tests.

```
bundle exec rspec
```
