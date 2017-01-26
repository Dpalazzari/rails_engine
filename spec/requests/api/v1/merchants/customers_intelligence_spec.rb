require 'rails_helper'

RSpec.describe 'Merchant Favorite Customer Endpoint API' do
	describe 'GET /api/v1/merchants/:id/favorite_customer' do
		it 'returns the favorite customer for a merchant' do
			merchant       = create(:merchant)
      top_customer   = create(:customer)
      worse_customer = create(:customer)
      invoice        = create(:invoice, merchant: merchant, customer: top_customer)
      invoice_2      = create(:invoice, merchant: merchant, customer: top_customer)
      invoice_3      = create(:invoice, merchant: merchant, customer: worse_customer)
      create(:transaction, result: 'success', invoice: invoice)
      create(:transaction, result: 'success', invoice: invoice_2)
      create(:transaction, result: 'success', invoice: invoice_3)

      get "/api/v1/merchants/#{merchant.id}/favorite_customer"

      customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(customer['id']).to eq(top_customer.id)
		end
	end
end
	