class Customer < ApplicationRecord
  has_many :invoices
  has_many :merchants, through: :invoices
  has_many :transactions, through: :invoices

  def favorite_merchant
	  merchants
		.select('merchants.*, count(invoices.merchant_id) as merchant_count')
		.joins(invoices: [:transactions])
		.merge(Transaction.successful)
		.group('merchants.id')
		.order('merchant_count desc')
		.first
  end
end
