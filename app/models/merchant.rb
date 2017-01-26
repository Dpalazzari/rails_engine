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

  def self.with_most_items(quantity)
    select('merchants.*, sum(invoice_items.quantity) as item_count')
      .joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.successful)
      .group('merchants.id')
      .order('item_count desc')
      .limit(quantity)
  end

  def customers_with_pending_invoices
    customers.find_by_sql("select customers.* from customers
    join invoices
    on customers.id = invoices.customer_id
    join transactions
    on invoices.id = transactions.invoice_id
    where transactions.result = 'failed'
    except
    select customers.* from customers
    join invoices
    on customers.id = invoices.customer_id
    join transactions
    on invoices.id = transactions.invoice_id
    where transactions.result = 'success'")
   end
end
