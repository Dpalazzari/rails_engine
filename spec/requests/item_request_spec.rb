require 'rails_helper'

RSpec.describe "Item request API", type: :request do
	it "returns a list of all items" do
		create_list(:item, 3)

		get '/api/v1/items'

		items = JSON.parse(response.body)
		
		expect(response).to be_success
		item 		= items.first
		db_item = Item.first

		expect(items.count).to eq(3)
		verify_item_attributes(item, db_item)
	end

	it "returns a single item" do
		db_item = create(:item)

		get "/api/v1/items/#{db_item.id}"

		item = JSON.parse(response.body)

		expect(response).to be_success
		verify_item_attributes(item, db_item)
	end
end 