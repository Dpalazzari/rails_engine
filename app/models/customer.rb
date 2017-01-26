class Customer < ApplicationRecord
  has_many :invoices
  has_many :merchants, through: :invoices
  has_many :transactions, through: :invoices

  def favorite_merchant
  	# returns a merchant where the customer 
	  # has conducted the most successful transactions

	 #  select count('invoices.merchant_id') as merchant_count, merchants.*
		# from customers
		# join invoices
		# on invoices.customer_id = customers.id
		# join transactions
		# on invoices.id = transactions.invoice_id
		# join merchants
		# on invoices.merchant_id = merchants.id where transactions.result = 'success' and customers.id = 66
		# group by merchants.id order by merchant_count DESC
		# limit(1);
		# binding.pry
		merchants
		.select('merchants.*, count(invoices.merchant_id) as merchant_count')
		.joins(invoices: [:transactions])
		.merge(Transaction.successful).group('merchants.id')
		.order('merchant_count desc')
		.first
  end
end
