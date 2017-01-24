require 'rails_helper'

RSpec.describe "Item request API", type: :request do
	it "returns a list of all items" do
		create_list(:item, 3)

		get '/api/v1/items'

		items = JSON.parse(response.body)
		
		expect(response).to be_success

		item = items.first

		expect(items.count).to eq(3)
		expect(item).to have_key('id')
		expect(item['id']).to be_a(Integer)
		expect(item).to have_key('name')
		expect(item['name']).to be_a(String)
		expect(item).to have_key('description')
		expect(item['description']).to be_a(String)
		expect(item).to have_key('unit_price')
		expect(item['unit_price']).to be_a(Integer)
	end

	xit "" do

	end
end 