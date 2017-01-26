require 'rails_helper'

RSpec.describe 'Item intelligence endpoints' do
  describe 'GET /api/v1/merchants/most_items?quantity=x' do
    it 'returns top 5 merchants with most items sold' do
      merchants = create_list(:merchant, 10)
      (merchants.length - 1).times do |i|
        invoices = create_list(:invoice, i + 1, merchant: merchants[i])
        invoices.each do |invoice|
          create(:transaction, invoice: invoice)
          create_list(:invoice_item, i + 1, invoice: invoice)
        end
      end

      get '/api/v1/merchants/most_items?quantity=5'
      json_merchants = JSON.parse(response.body)

      expect(response).to be_success

      result   = Merchant.with_most_items(5).map { |m| m.invoice_items.sum(:quantity) }
      expected = [81, 64, 49, 36, 25]
      expect(result).to eq(expected)
    end
  end
end
