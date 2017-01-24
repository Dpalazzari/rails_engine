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

	it "finds first item by name" do
		db_item = create(:item)

		get "/api/v1/items/find?name=#{db_item.name}"

		item = JSON.parse(response.body)
		expect(response).to be_success
		verify_item_attributes(item, db_item)
	end

	it "finds first item by name ignoring case" do
		db_item = create(:item)

		get "/api/v1/items/find?name=#{db_item.name.upcase}"

		item = JSON.parse(response.body)
		expect(response).to be_success
		verify_item_attributes(item, db_item)
	end

	it "finds first item by description" do
		db_item = create(:item)

		get "/api/v1/items/find?description=#{db_item.description}"

		item = JSON.parse(response.body)
		expect(response).to be_success
		verify_item_attributes(item, db_item)
	end
	
	it "finds first item by description ignoring case" do
		db_item = create(:item)

		get "/api/v1/items/find?description=#{db_item.description.upcase}"

		item = JSON.parse(response.body)
		expect(response).to be_success
		verify_item_attributes(item, db_item)
	end

	it "finds first item by unit_price" do
		db_item = create(:item)

		get "/api/v1/items/find?unit_price=#{db_item.unit_price}"

		item = JSON.parse(response.body)
		expect(response).to be_success
		verify_item_attributes(item, db_item)
	end

	it "finds first item by created_at" do
		db_item = create(:item)

		get "/api/v1/items/find?created_at=#{db_item.created_at}"
		item = JSON.parse(response.body)

		expect(response).to be_success
		verify_item_attributes(item, db_item)
	end

	it "finds first item by updated_at" do
		db_item = create(:item)

		get "/api/v1/items/find?updated_at=#{db_item.updated_at}"
		item = JSON.parse(response.body)
		
		expect(response).to be_success
		verify_item_attributes(item, db_item)
	end

	it "finds all items by name" do
		items = create_list(:item, 3)
		db_item = items.first

		get "/api/v1/items/find_all?name=#{db_item.name}" 

		item = JSON.parse(response.body).first

		expect(response).to be_success
		verify_item_attributes(item, db_item)
	end

	it "finds all items by name ignoring case" do
		name = create_list(:item, 3).first.name
		create(:item, name: 'SAMPLE')

		get "/api/v1/items/find_all?name=#{name.upcase}"

		items = JSON.parse(response.body)

		names = items.map { |item| item['name'] }
			
		expect(response).to be_success
		expect(items.count).to eq(3)
		expect(items.count).to_not eq(Item.count)
		expect(names.all? { |n| n == name }).to be true
	end

	it "finds all items by description" do
		items = create_list(:item, 3)
		db_item = items.first

		get "/api/v1/items/find_all?description=#{db_item.description}" 

		item = JSON.parse(response.body).first

		expect(response).to be_success
		verify_item_attributes(item, db_item)
	end

	it "finds all items by description ignoring case" do
		description = create_list(:item, 3).first.description
		create(:item, description: 'SAMPLE')

		get "/api/v1/items/find_all?description=#{description.upcase}"

		items = JSON.parse(response.body)

		descriptions = items.map { |item| item['description'] }

		expect(response).to be_success
		expect(items.count).to eq(3)
		expect(items.count).to_not eq(Item.count)
		expect(descriptions.all? { |d| d == description }).to be true
	end

	it "finds all items by unit_price" do
		items = create_list(:item, 3)
		db_item = items.first

		get "/api/v1/items/find_all?unit_price=#{db_item.unit_price}" 

		item = JSON.parse(response.body).first

		expect(response).to be_success
		verify_item_attributes(item, db_item)
	end

	it "finds all items matching created_at timestamps" do
		create_list(:item, 3)
		created = Item.first.created_at.to_json

		get "/api/v1/items/find_all?created_at=#{created}"

		expect(response).to be_success

		items = JSON.parse(response.body)
		created_ats = items.map { |item| item['created_at'] }

		expect(items.count).to eq(3)
		expect(created_ats.all? { |c| created.include?(c) }).to be true
	end

	it "finds all items matching updated_at timestamps" do
		create_list(:item, 3)
		updated = Item.first.updated_at.to_json

		get "/api/v1/items/find_all?updated_at=#{updated}"

		expect(response).to be_success

		items = JSON.parse(response.body)
		updated_ats = items.map { |item| item['updated_at'] }

		expect(items.count).to eq(3)
		expect(updated_ats.all? { |u| updated.include?(u) }).to be true
	end

	it "finds a random item" do
		create_list(:item, 100)

		get '/api/v1/items/random'

		item_1 = JSON.parse(response.body)
		db_item = Item.find(item_1['id'])

		get '/api/v1/items/random'	
		
		item_2 = JSON.parse(response.body)	
		db_item2 = Item.find(item_2['id'])
		
		expect(item_1).to_not eq(item_2)
	end
end 