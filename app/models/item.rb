class Item < ApplicationRecord
  belongs_to :merchant

  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  default_scope { order(:id) }

  def best_day
		invoices.joins(:invoice_items)
      .group('invoices.id')
      .order("sum(invoice_items.quantity) DESC, invoices.created_at desc")
      .first
      .created_at
  end

  def self.most_revenue(quantity)
    unscoped.joins(invoice_items: [invoice: :transactions])
      .merge(Transaction.successful)
      .group('items.id')
      .order('sum(invoice_items.quantity * invoice_items.unit_price) desc')
      .limit(quantity)
  end

  def self.most_items(quantity)
    unscoped.joins(invoice_items: [invoice: :transactions])
      .merge(Transaction.successful)
      .group("items.id")
      .order("sum(invoice_items.quantity) desc")
      .limit(quantity)
  end
end
