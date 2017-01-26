require 'rails_helper'

RSpec.describe 'Item intelligence endpoints' do
  describe 'GET /api/v1/merchants/most_items?quantity=x' do
    before do
      merchants = create_list(:merchant, 5)
      (merchants.length - 1).times do |i|
        invoices = create_list(:invoice, i + 1, merchant: merchants[i])
        invoices.each do |invoice|
          create(:transaction, invoice: invoice)
          create_list(:invoice_item, i + 1, invoice: invoice)
        end
      end
    end

    it 'returns top 3 merchants with most items sold' do
      get '/api/v1/merchants/most_items?quantity=3'

      expect(response).to be_success

      merchant_ids = JSON.parse(response.body).map { |merchant| merchant['id'] }
      result       = Merchant.where(id: merchant_ids).map { |merchant| merchant.invoice_items.sum(:quantity) }

      expected = [16, 9, 4]
      expect(result).to match_array(expected)
    end

    it 'returns top 4 merchants with most items sold' do
      get '/api/v1/merchants/most_items?quantity=4'

      expect(response).to be_success

      merchant_ids = JSON.parse(response.body).map { |merchant| merchant['id'] }
      result       = Merchant.where(id: merchant_ids).map { |merchant| merchant.invoice_items.sum(:quantity) }

      expected = [16, 9, 4, 1]
      expect(result).to match_array(expected)
    end
  end
end
