require 'rails_helper'

RSpec.describe 'Transaction relationship API', type: :request do
	describe "get '/api/v1/transactions/:id/invoice'" do
		it 'returns the invoice of a transaction' do
      invoice = create(:invoice)
      transaction = create(:transaction, invoice: invoice)

      get "/api/v1/transactions/#{transaction.id}/invoice"
      json_invoice = JSON.parse(response.body)

      expect(response).to be_success
      expect(json_invoice['id']).to eq(transaction.invoice_id)
		end
	end
end
