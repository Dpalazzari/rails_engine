require 'rails_helper'

RSpec.describe 'Transactions API requests', type: :request do
  it 'returns a list of transactions' do
    create_list(:transaction, 3)

    get '/api/v1/transactions'

    expect(response).to be_success

    transactions   = parse_body
    transaction    = transactions.first
    db_transaction = Transaction.first

    expect(transactions.count).to eq(3)

    verify_transaction_attributes(transaction, db_transaction)
  end

  it 'returns a single transaction' do
    db_transaction = create(:transaction)

    get "/api/v1/transactions/#{db_transaction.id}"
    expect(response).to be_success
    transaction = parse_body

    verify_transaction_attributes(transaction, db_transaction)
  end

  it 'can find a transaction by id' do
    db_transaction = create(:transaction)

    get "/api/v1/transactions/find?id=#{db_transaction.id}"
    transaction = parse_body

    verify_transaction_attributes(transaction, db_transaction)
  end

  it 'can find a transaction by credit card number' do
    db_transaction = create(:transaction)

    get "/api/v1/transactions/find?credit_card_number=#{db_transaction.credit_card_number}"
    transaction = parse_body

    verify_transaction_attributes(transaction, db_transaction)
  end

  it 'can find a transaction by result' do
    db_transaction = create(:transaction)

    get "/api/v1/transactions/find?result=#{db_transaction.result}"
    transaction = parse_body

    verify_transaction_attributes(transaction, db_transaction)
  end

  it 'can find a transaction by result ignoring case' do
    db_transaction = create(:transaction)

    get "/api/v1/transactions/find?result=#{db_transaction.result.upcase}"
    transaction = parse_body

    verify_transaction_attributes(transaction, db_transaction)
  end

  it 'can find a transaction by created_at' do
    db_transaction = create(:transaction)

    get "/api/v1/transactions/find?created_at=#{db_transaction.created_at}"
    transaction = parse_body

    verify_transaction_attributes(transaction, db_transaction)
  end

  it 'can find a transaction by updated_at' do
    db_transaction = create(:transaction)

    get "/api/v1/transactions/find?updated_at=#{db_transaction.updated_at}"
    transaction = parse_body

    verify_transaction_attributes(transaction, db_transaction)
  end

  it 'can find all transactions by credit card number' do
    number = create_list(:transaction, 2).first.credit_card_number
    create(:transaction, credit_card_number: 1234)

    get "/api/v1/transactions/find_all?credit_card_number=#{number}"
    transactions = parse_body
    numbers      = transactions.map { |transaction| transaction['credit_card_number'] }

    expect(Transaction.count).to eq(3)
    expect(transactions.count).to eq(2)
    expect(numbers.all? { |n| n == number }).to be(true)
  end

  it 'can find all transactions by result' do
    result = create_list(:transaction, 2).first.result
    create(:transaction, result: 'nothing')

    get "/api/v1/transactions/find_all?result=#{result}"
    transactions = parse_body
    results      = transactions.map { |transaction| transaction['result'] }

    expect(Transaction.count).to eq(3)
    expect(transactions.count).to eq(2)
    expect(results.all? { |r| r == result }).to be(true)
  end

  it "finds all transactions matching created_at timestamps" do
    create_list(:transaction, 3, created_at: Time.now)
    created = Transaction.first.created_at.to_json

    get "/api/v1/transactions/find_all?created_at=#{created}"

    expect(response).to be_success

    transactions = JSON.parse(response.body)
    db_transactions = Transaction.where(id: transactions.map { |tr| tr['created_at'] })
    created_ats = db_transactions.map { |transaction| transaction['created_at'] }

    expect(transactions.count).to eq(3)
    expect(created_ats.all? { |c| c == created }).to be true
  end

  it "finds all transactions matching updated_at timestamps" do
    create_list(:transaction, 3, updated_at: Time.now)
    updated = Transaction.first.updated_at.to_json

    get "/api/v1/transactions/find_all?updated_at=#{updated}"

    expect(response).to be_success

    transactions = JSON.parse(response.body)
    db_transactions = Transaction.where(id: transactions.map { |tr| tr['updated_at'] })
    updated_ats = db_transactions.map { |transaction| transaction['updated_at'] }

    expect(transactions.count).to eq(3)
    expect(updated_ats.all? { |u| u == updated }).to be true
  end

  it 'shows a random transaction' do
    create_list(:transaction, 100)

    get '/api/v1/transactions/random'
    transaction1   = parse_body
    db_transaction = Transaction.find(transaction1['id'])

    get '/api/v1/transactions/random'
    transaction2 = parse_body
    db_transaction2 = Transaction.find(transaction2['id'])

    verify_transaction_attributes(transaction1, db_transaction)
    verify_transaction_attributes(transaction2, db_transaction2)

    expect(transaction1).to_not eq(transaction2)
  end
end
