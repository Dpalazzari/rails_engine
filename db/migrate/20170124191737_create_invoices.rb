class CreateInvoices < ActiveRecord::Migration[5.0]
  def change
    create_table :invoices do |t|
      t.citext :status

      t.datetime :created_at, precision: 0
      t.datetime :updated_at, precision: 0  
    end
  end
end
