# README

[![Code Climate](https://codeclimate.com/github/tmikeschu/rails_engine/badges/gpa.svg)](https://codeclimate.com/github/tmikeschu/rails_engine)

This is an API that serves information from an e-commerce database.

To run locally:

After cloning the app onto your machine:
```
cd rails_engine
bundle install
```

To create and seed the database:
```
rake db:create
rake db:migrate
rake load_data:all
```

To run full test suite from terminal: `rspec`

## Endpoints

[Endpoint Routes](https://github.com/tmikeschu/rails_engine/blob/master/config/routes.rb)
