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

	describe 'GET /api/v1/items/most_revenue?quantity=x' do
		it 'returns the top 2 items by revenue' do
			item1    = create(:item, name: 'Drew')
			item2    = create(:item, name: 'Mike')
			item3    = create(:item, name: 'Bilbo')
			invoice = create(:invoice)
			create(:transaction, invoice: invoice)
			invoice_item1 = create(:invoice_item, invoice: invoice, item: item1, quantity: 14, unit_price: 14)
			invoice_item2 = create(:invoice_item, invoice: invoice, item: item2, quantity: 14, unit_price: 2)
			invoice_item3 = create(:invoice_item, invoice: invoice, item: item3, quantity: 14, unit_price: 3)

			get '/api/v1/items/most_revenue?quantity=2'
			expect(response).to be_success

			items = JSON.parse(response.body)
			result = items.map { |item| item['id'] }
			expect(result).to match_array([item1.id,item3.id])
		end
	end
end
