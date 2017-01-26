class Customer < ApplicationRecord
  has_many :invoices
  has_many :merchants, through: :invoices
  has_many :transactions, through: :invoices

  def favorite_merchant
  	# returns a merchant where the customer 
	  # has conducted the most successful transactions
	  binding.pry
  end
end
