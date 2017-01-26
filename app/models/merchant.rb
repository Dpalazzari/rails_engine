class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def revenue(date = nil)
    return revenue_by_date(date) if date

     invoices.joins(:invoice_items, :transactions)
      .merge(Transaction.successful)
      .sum('invoice_items.quantity * invoice_items.unit_price')
  end

  def revenue_by_date(date)
    invoices
      .where('invoices.created_at = ?', date)
      .joins(:invoice_items, :transactions)
      .merge(Transaction.successful)
      .sum('invoice_items.quantity * invoice_items.unit_price')
  end

end
