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

end
