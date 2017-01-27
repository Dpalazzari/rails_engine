class Item < ApplicationRecord
  belongs_to :merchant

  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  default_scope { order(:id) }

  def best_day
		invoices
      .joins(:invoice_items)
      .group('invoices.id')
      .order("sum(invoice_items.quantity) DESC, invoices.created_at DESC")
      .first
      .created_at
  end

  def self.most_revenue(quantity)
    Item.find_by_sql(
      "select i.*, sum(in_it.quantity * in_it.unit_price) as revenue
      from items i
      join invoice_items in_it
      on i.id = in_it.item_id
      join invoices inv
      on in_it.invoice_id = inv.id
      join transactions t
      on t.invoice_id = inv.id
      where t.result = 'success'
      group by i.id
      order by revenue desc
      limit (#{quantity})"
     )
  end

  def self.most_items(quantity)
    unscoped.joins(invoice_items: [invoice: :transactions])
      .merge(Transaction.successful)
      .group("items.id")
      .order("sum(invoice_items.quantity) DESC")
      .limit(quantity)
  end
end
