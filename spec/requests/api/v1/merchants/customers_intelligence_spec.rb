require 'rails_helper'

RSpec.describe 'Merchant Customer Endpoint API' do
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

  describe 'GET /api/v1/merchants/:id/customers_with_pending_invoices' do
    it 'returns the customers with pending invoices' do
      merchant  = create(:merchant)
      customer  = create(:customer)
      customer2 = create(:customer)
      invoice   = create(:invoice, merchant: merchant, customer: customer)
      invoice2  = create(:invoice, merchant: merchant, customer: customer2)
      invoice.transactions << create_list(:transaction, 4, result: 'failed')
      invoice2.transactions << create_list(:transaction, 4, result: 'success')

      get "/api/v1/merchants/#{merchant.id}/customers_with_pending_invoices"

      customers = JSON.parse(response.body)

      expect(response).to be_success
      expect(response.body).to include_json([{"id"=>customer.id, "first_name"=>customer.first_name, "last_name"=>customer.last_name}])
    end
  end
end
	