require 'rails_helper'

RSpec.describe 'Customers Record API', type: :request do
  it 'returns a list of customers' do
    create_list(:customer, 3)

    get '/api/v1/customers'

    expect(response).to be_success

    customers   = parse_body
    customer    = customers.first
    db_customer = Customer.first

    expect(customers.count).to eq(3)

    verify_customer_attributes(customer, db_customer)
  end

  it 'returns a single customer' do
    db_customer = create(:customer)

    get "/api/v1/customers/#{db_customer.id}"
    expect(response).to be_success
    customer = parse_body

    verify_customer_attributes(customer, db_customer)
  end

  it 'can find a customer by id' do
    db_customer = create(:customer)

    get "/api/v1/customers/find?id=#{db_customer.id}"
    customer = parse_body

    verify_customer_attributes(customer, db_customer)
  end

  it 'can find a customer by first name' do
    db_customer = create(:customer)

    get "/api/v1/customers/find?first_name=#{db_customer.first_name}"
    customer = parse_body

    verify_customer_attributes(customer, db_customer)
  end

  it 'can find a customer by last name' do
    db_customer = create(:customer)

    get "/api/v1/customers/find?last_name=#{db_customer.last_name}"
    customer = parse_body

    verify_customer_attributes(customer, db_customer)
  end

  xit 'can find a customer by created_at' do
    db_customer = create(:customer)

    get "/api/v1/customers/find?created_at=#{db_customer.created_at}"
    customer = parse_body

    verify_customer_attributes(customer, db_customer)
  end

  it 'can find all customers based on a first name' do
    name = create_list(:customer, 2).first.first_name
    create(:customer, first_name: 'INSANE')

    get "/api/v1/customers/find_all?first_name=#{name}"
    customers = parse_body
    names     = customers.map { |customer| customer['first_name'] }

    expect(Customer.count).to eq(3)
    expect(customers.count).to eq(2)
    expect(names.all? { |n| n == name }).to be(true)
  end

  it 'can find all customers based on a last name' do
    name = create_list(:customer, 2).first.last_name
    create(:customer, last_name: 'INSANE')

    get "/api/v1/customers/find_all?last_name=#{name}"
    customers = parse_body
    names     = customers.map { |customer| customer['last_name'] }

    expect(Customer.count).to eq(3)
    expect(customers.count).to eq(2)
    expect(names.all? { |n| n == name }).to be(true)
  end

  it 'shows a random customer' do
    create_list(:customer, 100)

    get '/api/v1/customers/random'
    customer1   = parse_body
    db_customer = Customer.find(customer1['id'])

    get '/api/v1/customers/random'
    customer2 = parse_body
    db_customer2 = Customer.find(customer2['id'])

    verify_customer_attributes(customer1, db_customer)
    verify_customer_attributes(customer2, db_customer2)

    expect(customer1).to_not eq(customer2)
  end
end
