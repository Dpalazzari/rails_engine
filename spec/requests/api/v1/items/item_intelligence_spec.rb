require 'rails_helper'

RSpec.describe 'Item Best Day Endpoint API' do
	describe 'GET /api/v1/items/:id/best_day' do
		it 'returns the best day by date' do
			item 		= create(:item)
			invoice = create(:invoice)
			invoice_2 = create(:invoice)
      date = invoice_2.created_at
      invoice_2.update(created_at: date - 10.days) 
			create_list(:invoice_item, 4, item: item, invoice: invoice)

			get "/api/v1/items/#{item.id}/best_day"

			time = JSON.parse(response.body)

			expect(response).to be_success
			expect(invoice.created_at.to_json).to include(time['best_day'])
		end
	end
end