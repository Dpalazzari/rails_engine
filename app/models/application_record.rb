class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.random
    unscoped.limit(1).order('RANDOM()').first
  end
end
