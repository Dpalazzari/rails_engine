require 'rails_helper'

RSpec.describe 'Item Best Day Endpoint API' do
	describe 'GET /api/v1/items/:id/best_day' do
		it 'returns the best day by date' do
			item 		= create(:item)
			invoice = create(:invoice)
			create_list(:invoice_item, 4, item: item, invoice: invoice)

			get "/api/v1/items/#{item.id}/best_day"

			time = JSON.parse(response.body)

			expect(response).to be_success
			expect(invoice.created_at.to_json).to include(time)
		end
	end
end