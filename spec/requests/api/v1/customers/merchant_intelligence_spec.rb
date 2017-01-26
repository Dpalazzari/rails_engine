require 'rails_helper'

RSpec.describe 'Customer Favorite Merchant Intelligence' do
	describe 'GET /api/v1/customers/:id/favorite_merchant' do
		it 'returns the favorite merchant for a customer' do
			customer 			 = create(:customer)
			top_merchant 	 = create(:merchant)
			worse_merchant = create(:merchant)
			invoice 			 = create(:invoice, merchant: top_merchant, customer: customer)
			invoice_3 		 = create(:invoice, merchant: top_merchant, customer: customer)
			invoice_2			 = create(:invoice, merchant: worse_merchant, customer: customer)
			create(:transaction, result: 'success', invoice: invoice)
			create(:transaction, result: 'success', invoice: invoice_2)
			create(:transaction, result: 'success', invoice: invoice_3)

			get "/api/v1/customers/#{customer.id}/favorite_merchant"

			merchant = JSON.parse(response.body)

			expect(response).to be_success
			expect(merchant['id']).to eq(top_merchant.id)
		end
	end
end