# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'
require 'csv'

namespace :load_data do
  task :customers => :environment do
    data        = File.read("data/customers.csv")
    parsed_data = CSV.parse(data, headers: true)
    parsed_data.each do |row|
      Customer.create(row.to_hash)
    end
  end

  task :merchants => :environment do
    data        = File.read("data/merchants.csv")
    parsed_data = CSV.parse(data, headers: true)
    parsed_data.each do |row|
      Merchant.create(row.to_hash)
    end
  end

  def import(model)
    data        = File.read("data/#{model + 's'}.csv")
    parsed_data = CSV.parse(data, headers: true)
    parsed_data.each do |row|
      model.camelize.constantize.create(row.to_hash)
    end
  end
end


Rails.application.load_tasks
