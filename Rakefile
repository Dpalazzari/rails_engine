# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'
require 'csv'

namespace :load_data do
  task :all => :environment do
    %w(customer merchant item invoice invoice_item transaction).each do |model|
      import_csv(model)
    end
  end

  # task :customers => :environment do
  #   data        = File.read("data/customers.csv")
  #   parsed_data = CSV.parse(data, headers: true)
  #   parsed_data.each do |row|
  #     Customer.create(row.to_hash)
  #   end
  # end

  # task :merchants => :environment do
  #   data        = File.read("data/merchants.csv")
  #   parsed_data = CSV.parse(data, headers: true)
  #   parsed_data.each do |row|
  #     Merchant.create(row.to_hash)
  #   end
  # end

  # task :items => :environment do
  #   data        = File.read("data/items.csv")
  #   parsed_data = CSV.parse(data, headers: true)
  #   parsed_data.each do |row|
  #     Item.create(row.to_hash)
  #   end
  # end

  # task :invoices => :environment do
  #   data        = File.read("data/invoices.csv")
  #   parsed_data = CSV.parse(data, headers: true)
  #   parsed_data.each do |row|
  #     Invoice.create(row.to_hash)
  #   end
  # end

  # task :transactions => :environment do
  #   data        = File.read("data/transactions.csv")
  #   parsed_data = CSV.parse(data, headers: true)
  #   parsed_data.each do |row|
  #     Transaction.create(row.to_hash)
  #   end
  # end

  # task :invoice_items => :environment do
  #   data        = File.read("data/invoice_items.csv")
  #   parsed_data = CSV.parse(data, headers: true)
  #   parsed_data.each do |row|
  #     InvoiceItem.create(row.to_hash)
  #   end
  # end

  # Refactor if possible?
  def import_csv(model)
    data        = File.read("data/#{model + 's'}.csv")
    parsed_data = CSV.parse(data, headers: true)
    parsed_data.each do |row|
      model.camelize.constantize.create(row.to_hash)
    end
  end
end


Rails.application.load_tasks
