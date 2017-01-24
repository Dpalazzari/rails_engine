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
end
