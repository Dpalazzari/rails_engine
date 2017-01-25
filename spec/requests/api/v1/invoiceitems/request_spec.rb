require 'rails_helper'

RSpec.describe "InvoiceItem request API", type: :request do
	it "returns a list of all invoice items" do
		create_list(:invoice_item, 3)

		get '/api/v1/invoice_items'

		invoice_items = JSON.parse(response.body)

		expect(response).to be_success

		invoice_item 	= invoice_items.first
		db_invoice_item = InvoiceItem.first

		expect(invoice_items.count).to eq(3)
		verify_invoice_item_attributes(invoice_item, db_invoice_item)
	end

	it "returns a single invoice item" do
		db_invoice_item = create(:invoice_item)

		get "/api/v1/invoice_items/#{db_invoice_item.id}"

		invoice_item = JSON.parse(response.body)

		expect(response).to be_success
		verify_invoice_item_attributes(invoice_item, db_invoice_item)
	end

	it "finds first invoice item by id" do
		db_invoice_item = create(:invoice_item)

		get "/api/v1/invoice_items/find?id=#{db_invoice_item.id}"

		invoice_item = JSON.parse(response.body)

		expect(response).to be_success
		verify_invoice_item_attributes(invoice_item, db_invoice_item)
	end

	it "finds first invoice item by quantity" do
		db_invoice_item = create(:invoice_item)

		get "/api/v1/invoice_items/find?quantity=#{db_invoice_item.quantity}"

		invoice_item = JSON.parse(response.body)

		expect(response).to be_success
		verify_invoice_item_attributes(invoice_item, db_invoice_item)
	end

	it "finds first invoice item by unit_price" do
		db_invoice_item = create(:invoice_item)

		get "/api/v1/invoice_items/find?unit_price=#{db_invoice_item.unit_price}"

		invoice_item = JSON.parse(response.body)

		expect(response).to be_success
		verify_invoice_item_attributes(invoice_item, db_invoice_item)
	end

	it "finds first invoice item by created_at" do
		db_invoice_item = create(:invoice_item)

		get "/api/v1/invoice_items/find?created_at=#{db_invoice_item.created_at}"

		invoice_item = JSON.parse(response.body)

		expect(response).to be_success
		verify_invoice_item_attributes(invoice_item, db_invoice_item)
	end

	it "finds first invoice item by updated_at" do
		db_invoice_item = create(:invoice_item)

		get "/api/v1/invoice_items/find?updated_at=#{db_invoice_item.updated_at}"

		invoice_item = JSON.parse(response.body)

		expect(response).to be_success
		verify_invoice_item_attributes(invoice_item, db_invoice_item)
	end

	it "finds all invoice items by quantity" do
		invoice_items = create_list(:invoice_item, 3)
		db_invoice_item = invoice_items.first

		get "/api/v1/invoice_items/find_all?quantity=#{db_invoice_item.quantity}"

		invoice_item = JSON.parse(response.body).first

		expect(response).to be_success
		verify_invoice_item_attributes(invoice_item, db_invoice_item)
	end

	it "finds all invoice items by unit_price" do
		invoice_items = create_list(:invoice_item, 3)
		db_invoice_item = invoice_items.first

		get "/api/v1/invoice_items/find_all?unit_price=#{db_invoice_item.unit_price}"

		invoice_item = JSON.parse(response.body).first

		expect(response).to be_success
		verify_invoice_item_attributes(invoice_item, db_invoice_item)
	end

	it "finds all invoice items by created_at" do
		create_list(:invoice_item, 3, created_at: Time.now)
		created = InvoiceItem.first.created_at.to_json

		get "/api/v1/invoice_items/find_all?created_at=#{created}"

		invoice_items = JSON.parse(response.body)
		db_invoice_items = InvoiceItem.where(id: invoice_items.map { |inv| inv['created_at'] })
		created_ats = db_invoice_items.map { |invoice_item| invoice_item['created_at']}

		expect(response).to be_success
		expect(invoice_items.count).to eq(3)
		expect(created_ats.all? { |c| c == created }).to be true
	end

	it "finds all invoice items by updated_at" do
		create_list(:invoice_item, 3, updated_at: Time.now)
		updated = InvoiceItem.first.updated_at.to_json

		get "/api/v1/invoice_items/find_all?updated_at=#{updated}"

		invoice_items = JSON.parse(response.body)
		db_invoice_items = InvoiceItem.where(id: invoice_items.map { |inv| inv['updated_at'] })
		updated_ats = db_invoice_items.map { |invoice_item| invoice_item['updated_at']}

		expect(response).to be_success
		expect(invoice_items.count).to eq(3)
		expect(updated_ats.all? { |u| u == updated }).to be true
	end

	it "finds a random invoice item" do
		create_list(:invoice_item, 100)

		get '/api/v1/invoice_items/random'

		invoice_item_1 = JSON.parse(response.body)
		db_invoice_item_1 = InvoiceItem.find(invoice_item_1['id'])

		get '/api/v1/invoice_items/random'

		invoice_item_2 = JSON.parse(response.body)
		db_invoice_item_2 = InvoiceItem.find(invoice_item_2['id'])

		expect(invoice_item_1).to_not eq(invoice_item_2)
	end

end
