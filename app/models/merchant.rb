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
    invoices.where('invoices.created_at = ?', date)
      .joins(:invoice_items, :transactions)
      .merge(Transaction.successful)
      .sum('invoice_items.quantity * invoice_items.unit_price')
  end

  def self.with_most_items(quantity)
    joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.successful)
      .group('merchants.id')
      .order('sum(invoice_items.quantity) desc')
      .limit(quantity)
  end

  def customers_with_pending_invoices
    Customer.find_by_sql("select customers.* from customers
      join invoices
      on customers.id = invoices.customer_id
      where invoices.id in (
        select invoices.id
        from invoices
        join transactions
        on invoices.id = transactions.invoice_id
        where transactions.result = 'failed'
        and invoices.merchant_id = #{self.id}
        except
        select invoices.id
        from invoices
        join transactions
        on invoices.id = transactions.invoice_id
        where transactions.result = 'success'
        and invoices.merchant_id = #{self.id}
      )
      and invoices.merchant_id = #{self.id};")
  end

  def favorite_customer
    customers.joins(invoices: [:transactions])
      .merge(Transaction.successful)
      .group('customers.id')
      .order('count(invoices.merchant_id) desc')
      .first
  end

  def self.total_revenue(date)
    joins(invoices: [:invoice_items, :transactions])
      .where('invoices.created_at = ?', date)
      .merge(Transaction.successful)
      .sum('invoice_items.quantity * invoice_items.unit_price')
  end

  def self.most_revenue(quantity)
    joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.successful)
      .group('merchants.id')
      .order('sum(invoice_items.quantity * invoice_items.unit_price) desc')
      .limit(quantity)
  end

end
