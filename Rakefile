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

  def import_csv(model)
    data        = File.read("data/#{model + 's'}.csv")
    parsed_data = CSV.parse(data, headers: true)
    parsed_data.each do |row|
      model.camelize.constantize.create(row.to_hash)
    end
  end
end

Rails.application.load_tasks
