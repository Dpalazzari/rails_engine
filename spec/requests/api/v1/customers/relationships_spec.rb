require 'rails_helper'

RSpec.describe 'Customer relationships API', type: :request do
	describe "get '/api/v1/customers/:id/invoices'" do
		it 'returns invoices for customer' do
      customer = create(:customer)
      invoices = create_list(:invoice, 5, customer: customer)
      create(:invoice)

      get "/api/v1/customers/#{customer.id}/invoices"
      json_invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(Invoice.count).to eq(6)
      expect(json_invoices.count).to eq(5)
      expect(json_invoices.all? { |inv| inv['customer_id'] == customer.id }).to be true
		end
	end

	describe "get '/api/v1/customers/:id/transactions'" do
		it 'returns transactions for customer' do
      customer = create(:customer)
      invoice  = create(:invoice, customer: customer)
      invoice.transactions << create_list(:transaction, 5)
      create(:transaction)

      get "/api/v1/customers/#{customer.id}/transactions"
      json_transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(Transaction.count).to eq(6)
      expect(json_transactions.count).to eq(5)
      expect(json_transactions.all? { |tr| Invoice.find(tr['invoice_id']).customer_id == customer.id }).to be true
		end
	end
end
