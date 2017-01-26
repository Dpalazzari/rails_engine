class Customer < ApplicationRecord
  has_many :invoices
  has_many :merchants, through: :invoices
  has_many :transactions, through: :invoices

  def favorite_merchant
  	# returns a merchant where the customer 
	  # has conducted the most successful transactions
	  binding.pry
	  rails_engine_development=# select count('invoices.merchant_id') as merchant_count from customers
join invoices
on invoices.customer_id = customers.id
join transactions
on transactions.invoice_id = invoices.id
join merchants
on invoices.merchant_id = merchants.id
rails_engine_development-# where transactions.result = 'success';
  end
end
