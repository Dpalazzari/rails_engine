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
end
