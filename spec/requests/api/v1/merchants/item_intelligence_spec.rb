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
      get '/api/v1/merchants/most_items?quantity=5'

      expect(response).to be_success

      result   = Merchant.with_most_items(3).map { |m| m.invoice_items.sum(:quantity) }
      expected = [16, 9, 4]
      expect(result).to eq(expected)
    end

    it 'returns top 4 merchants with most items sold' do
      get '/api/v1/merchants/most_items?quantity=5'

      expect(response).to be_success

      result   = Merchant.with_most_items(4).map { |m| m.invoice_items.sum(:quantity) }
      expected = [16, 9, 4, 1]
      expect(result).to eq(expected)
    end
  end
end
