class Customer < ApplicationRecord
  has_many :invoices
  has_many :merchants, through: :invoices
  has_many :transactions, through: :invoices

  def favorite_merchant
	  merchants.joins(invoices: [:transactions])
			.merge(Transaction.successful)
			.group('merchants.id')
			.order('count(invoices.merchant_id) desc')
			.first
  end
end
