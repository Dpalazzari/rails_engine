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
		expect(item['unit_price']).to eq(db_item.unit_price)
		expect(item['unit_price']).to be_a(Integer)
	end

  def verify_merchant_attributes(merchant, db_merchant)
    expect(merchant).to have_key('id')
    expect(merchant['id']).to eq db_merchant.id
    expect(merchant['id']).to be_a(Integer)

    expect(merchant).to have_key('name')
    expect(merchant['name']).to eq db_merchant.name
    expect(merchant['name']).to be_a(String)
  end
end

