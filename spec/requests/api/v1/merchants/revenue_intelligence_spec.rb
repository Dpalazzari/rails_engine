require 'rails_helper'

RSpec.describe 'Merchant Revenue Intelligence' do
  describe '/api/v1/merchants/:id/revenue' do
    it 'returns total revenue for merchant' do
      merchant = create(:merchant)
      merchant.invoices << create_list(:invoice, 2)
      merchant.invoices.each do |invoice|
        invoice.transactions << create(:transaction)
        invoice.invoice_items << create(:invoice_item, unit_price: 100)
        invoice.invoice_items << create(:invoice_item, unit_price: 150, quantity: 2)
      end

      get "/api/v1/merchants/#{merchant.id}/revenue"

      expect(response).to be_success
      expect(response.body).to include_json({'revenue' => '8.00'})
    end
  end

  describe '/api/v1/merchants/:id/revenue?date=' do
    it 'returns total revenue on a given date' do
      merchant = create(:merchant)
      merchant.invoices << create_list(:invoice, 2)
      merchant.invoices.each do |invoice|
        invoice.transactions << create(:transaction)
        invoice.invoice_items << create(:invoice_item, unit_price: 100)
        invoice.invoice_items << create(:invoice_item, unit_price: 150, quantity: 2)
      end
      new_date = merchant.invoices.first.created_at + 10.days
      merchant.invoices.first.update(created_at: new_date)
      merchant.reload

      get "/api/v1/merchants/#{merchant.id}/revenue?date=#{new_date}"

      expect(response).to be_success
      expect(response.body).to include_json({'revenue' => '4.00'})
    end
  end
end
