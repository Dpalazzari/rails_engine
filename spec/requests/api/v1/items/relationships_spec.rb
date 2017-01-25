require 'rails_helper'

RSpec.describe 'Item relationships endpoints', type: :request do
	describe "get '/api/v1/items/:id/invoice_items" do
		it 'returns all invoice_items for item' do
			items = create_list(:item, 2)
      item  = items.first
			create_list(:invoice_item, 4, item_id: item.id)

			get "/api/v1/items/#{item.id}/invoice_items"

			invoice_items = JSON.parse(response.body)

			expect(response).to be_success
			expect(invoice_items.all? { |i| i['item_id'] == item.id }).to be true
		end
	end

  describe '/api/v1/items/:id/merchant' do
    it 'returns the item merchant' do
      merchant = create(:merchant)
      merchant.items << create(:item)
      item = Item.first

      get "/api/v1/items/#{item.id}/merchant"
      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant['id']).to eq(item.merchant_id)
    end
  end
end
