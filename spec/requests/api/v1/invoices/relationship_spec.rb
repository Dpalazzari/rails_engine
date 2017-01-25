require 'rails_helper'

RSpec.describe 'Invoices endpoints relationships', type: :request do
	describe "GET /api/v1/invoices/:id/transactions" do
		it "returns all transactions for an invoice" do
			invoice = create(:invoice)
			create_list(:transaction, 5, invoice_id: invoice.id)

			get "/api/v1/invoices/#{invoice.id}/transactions"

			invoice_transactions = JSON.parse(response.body)

			expect(response).to be_success
			expect(invoice_transactions.count).to eq(5)
		end
	end
end