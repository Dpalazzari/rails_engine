class Merchant < ApplicationRecord
  include ActionView::Helpers::NumberHelper

  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def successful_transactions
    transactions.where(result: 'success')
  end

  def revenue(date = nil)
    return revenue_by_date(date) if date

    cents = successful_transactions
      .joins(invoice: [:invoice_items])
      .sum('invoice_items.quantity * invoice_items.unit_price')
    revenue_dollars(cents)
  end

  def revenue_by_date(date)
    cents = successful_transactions
      .where('invoices.created_at = ?', date)
      .joins(invoice: [:invoice_items])
      .sum('invoice_items.quantity * invoice_items.unit_price')
    revenue_dollars(cents)
  end

  def revenue_dollars(cents)
    revenue = number_with_precision(cents / 100.00, precision: 2).to_s
    { 'revenue' => revenue }
  end
end
