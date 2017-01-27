# README

[![Code Climate](https://codeclimate.com/github/tmikeschu/rails_engine/badges/gpa.svg)](https://codeclimate.com/github/tmikeschu/rails_engine)

This is an API that serves information from an e-commerce database.

To run locally:

1. After cloning the app onto your machine...

2. From terminal: 
```
bundle install
rake db:create
rake db:migrate
```

3. To load all the csv data: `rake load_data:all`

4. To run full test suite from terminal: `rspec`

## Endpoints

[Endpoint Routes](https://github.com/tmikeschu/rails_engine/blob/master/config/routes.rb)



