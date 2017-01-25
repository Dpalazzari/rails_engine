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

	describe "GET /api/v1/invoices/:id/invoice_items" do
		it "returns all invoice items for an invoice" do
			invoice = create(:invoice)
			item = create(:item)
			create_list(:invoice_item, 5, invoice_id: invoice.id, item_id: item.id)

			get "/api/v1/invoices/#{invoice.id}/invoice_items"

			invoice_items = JSON.parse(response.body)

			expect(response).to be_success
			expect(invoice_items.count).to eq(5)
		end
	end

	describe "GET /api/v1/invoices/:id/items" do
		it "returns all items for an invoice" do
			invoice = create(:invoice)
			item = create(:item)
			create_list(:invoice_item, 5, invoice_id: invoice.id, item_id: item.id)

			get "/api/v1/invoices/#{invoice.id}/items"

			invoice_items = JSON.parse(response.body)

			expect(response).to be_success
			expect(invoice_items.count).to eq(5)
		end
	end

	describe "GET /api/v1/invoices/:id/customer" do
		it "returns the customer for an invoice" do
			customer = create(:customer)
			invoice = create(:invoice, customer_id: customer.id)

			get "/api/v1/invoices/#{invoice.id}/customer"

			invoice_customer = JSON.parse(response.body)

			expect(response).to be_success
			expect(invoice_customer['first_name']).to eq(customer.first_name)
		end
	end

	describe "GET /api/v1/invoices/:id/merchant" do
		it "returns the merchant for an invoice" do
			merchant = create(:merchant)
			invoice = create(:invoice, merchant_id: merchant.id)

			get "/api/v1/invoices/#{invoice.id}/merchant"

			invoice_merchant = JSON.parse(response.body)

			expect(response).to be_success
			expect(invoice_merchant['name']).to eq(merchant.name)
		end
	end
end