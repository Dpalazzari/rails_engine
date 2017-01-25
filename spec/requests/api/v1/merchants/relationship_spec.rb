require 'rails_helper'

RSpec.describe 'Merchants endpoints', type: :request do
	describe "get '/api/v1/merchants/:id/items" do
		it "returns all the items for a merchant" do
			merchant = create(:merchant)
			create_list(:item, 4, merchant_id: merchant.id)

			get "/api/v1/merchants/#{merchant.id}/items"

			merchant_items = JSON.parse(response.body)

			expect(response).to be_success
			expect(merchant_items.count).to eq(4)
			expect(merchant_items.all? { |i| i['merchant_id'] == merchant.id }).to be true
		end

		it "returns all the invoices for a merchant" do
			merchant = create(:merchant)
			customer = create(:customer)
			create_list(:invoice, 4, merchant_id: merchant.id, customer_id: customer.id)

			get "/api/v1/merchants/#{merchant.id}/invoices"

			merchant_invoices = JSON.parse(response.body)

			expect(response).to be_success
			expect(merchant_invoices.all? { |i| i['merchant_id'] == merchant.id }).to be true
		end
	end
end