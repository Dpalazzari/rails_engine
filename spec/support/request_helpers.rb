module RequestHelpers
  def verify_customer_attributes(customer, db_customer)
    expect(customer).to have_key('id')
    expect(customer['id']).to eq(db_customer.id)
    expect(customer['id']).to be_a(Integer)

    expect(customer).to have_key('first_name')
    expect(customer['first_name']).to eq(db_customer.first_name)
    expect(customer['first_name']).to be_a(String)

    expect(customer).to have_key('last_name')
    expect(customer['last_name']).to eq(db_customer.last_name)
    expect(customer['last_name']).to be_a(String)
  end

  def parse_body
    JSON.parse(response.body)
  end

	def verify_item_attributes(item, db_item)
		expect(item).to have_key('id')
		expect(item['id']).to eq(db_item.id)
		expect(item['id']).to be_a(Integer)

		expect(item).to have_key('name')
		expect(item['name']).to eq(db_item.name)
		expect(item['name']).to be_a(String)

		expect(item).to have_key('description')
		expect(item['description']).to eq(db_item.description)
		expect(item['description']).to be_a(String)

		expect(item).to have_key('unit_price')
    dollars = (db_item.unit_price / 100.00).to_s
		expect(item['unit_price']).to eq(dollars)
		expect(item['unit_price']).to be_a(String)
	end

  def verify_merchant_attributes(merchant, db_merchant)
    expect(merchant).to have_key('id')
    expect(merchant['id']).to eq(db_merchant.id)
    expect(merchant['id']).to be_a(Integer)

    expect(merchant).to have_key('name')
    expect(merchant['name']).to eq(db_merchant.name)
    expect(merchant['name']).to be_a(String)
  end

  def verify_transaction_attributes(transaction, db_transaction)
    expect(transaction).to have_key('id')
    expect(transaction['id']).to eq db_transaction.id
    expect(transaction['id']).to be_a(Integer)

    expect(transaction).to have_key('credit_card_number')
    expect(transaction['credit_card_number']).to eq db_transaction.credit_card_number
    expect(transaction['credit_card_number']).to be_a(Integer)

    expect(transaction).to have_key('result')
    expect(transaction['result']).to eq db_transaction.result
    expect(transaction['result']).to be_a(String)

    verify_timestamps(transaction, db_transaction)
  end

  def verify_invoice_attributes(invoice, db_invoice)
    expect(invoice).to have_key('id')
    expect(invoice['id']).to eq(db_invoice.id)
    expect(invoice['id']).to be_a(Integer)

    expect(invoice).to have_key('status')
    expect(invoice['status']).to eq(db_invoice.status)
    expect(invoice['status']).to be_a(String)

    verify_timestamps(invoice, db_invoice)
  end

  def verify_invoice_item_attributes(invoice_item, db_invoice_item)
    expect(invoice_item).to have_key('id')
    expect(invoice_item['id']).to eq(db_invoice_item.id)
    expect(invoice_item['id']).to be_a(Integer)

    expect(invoice_item).to have_key('unit_price')
    expect(invoice_item['unit_price']).to eq(db_invoice_item.unit_price)
    expect(invoice_item['unit_price']).to be_a(Integer)

    expect(invoice_item).to have_key('quantity')
    expect(invoice_item['quantity']).to eq(db_invoice_item.quantity)
    expect(invoice_item['quantity']).to be_a(Integer)

    verify_timestamps(invoice_item, db_invoice_item)
  end

  def verify_timestamps(json, db)
    expect(json).to have_key('created_at')
    expect(db.created_at.to_json).to include(json['created_at'])
    expect(json['created_at']).to be_a(String)

    expect(json).to have_key('updated_at')
    expect(db.updated_at.to_json).to include(json['updated_at'])
    expect(json['updated_at']).to be_a(String)
  end
end

