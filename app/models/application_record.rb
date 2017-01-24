class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.random
    id = pluck(:id).sample
    find(id)
  end
end
