require 'rails_helper'

RSpec.describe "Invoice request API", type: :request do
	it "returns a list of all invoices" do
		create_list(:invoice, 3)

		get '/api/v1/invoices'

		invoices = JSON.parse(response.body)

		expect(response).to be_success

		invoice 	= invoices.first
		db_invoice = Invoice.first

		expect(invoices.count).to eq(3)
		verify_invoice_attributes(invoice, db_invoice)
	end

	it "returns a single invoice" do
		db_invoice = create(:invoice)

		get "/api/v1/invoices/#{db_invoice.id}"

		invoice = JSON.parse(response.body)

		expect(response).to be_success
		verify_invoice_attributes(invoice, db_invoice)
	end

	it "finds first invoice by id" do
		db_invoice = create(:invoice)

		get "/api/v1/invoices/find?id=#{db_invoice.id}"

		invoice = JSON.parse(response.body)

		expect(response).to be_success
		verify_invoice_attributes(invoice, db_invoice)
	end

	it "finds first invoice by status" do
		db_invoice = create(:invoice)

		get "/api/v1/invoices/find?status=#{db_invoice.status}"

		invoice = JSON.parse(response.body)

		expect(response).to be_success
		verify_invoice_attributes(invoice, db_invoice)
	end

	it "finds first invoice by status by ignoring case" do
		db_invoice = create(:invoice)

		get "/api/v1/invoices/find?status=#{db_invoice.status.upcase}"

		invoice = JSON.parse(response.body)

		expect(response).to be_success
		verify_invoice_attributes(invoice, db_invoice)
	end

	it "finds first invoice by created_at" do
		db_invoice = create(:invoice)

		get "/api/v1/invoices/find?created_at=#{db_invoice.created_at}"

		invoice = JSON.parse(response.body)

		expect(response).to be_success
		verify_invoice_attributes(invoice, db_invoice)
	end

	it "finds first invoice by updated_at" do
		db_invoice = create(:invoice)

		get "/api/v1/invoices/find?updated_at=#{db_invoice.updated_at}"

		invoice = JSON.parse(response.body)

		expect(response).to be_success
		verify_invoice_attributes(invoice, db_invoice)
	end

	it "finds all items by status" do
		invoices = create_list(:invoice, 3)
		db_invoice = invoices.first

		get "/api/v1/invoices/find_all?status=#{db_invoice.status}"

		invoice = JSON.parse(response.body).first

		expect(response).to be_success
		verify_invoice_attributes(invoice, db_invoice)
	end

	it "finds all items by status regardless of case" do
		status = create_list(:invoice, 3).first.status
		create(:invoice, status: 'SAMPLE')

		get "/api/v1/invoices/find_all?status=#{status.upcase}"

		invoices = JSON.parse(response.body)

		statuses = invoices.map { |invoice| invoice['status'] } 

		expect(response).to be_success
		expect(invoices.count).to eq(3)
		expect(invoices.count).to_not eq(Invoice.count)
		expect(statuses.all? { |s| s == status }).to be true
	end

	it "finds all items by created_at" do
		create_list(:invoice, 3)
		created = Invoice.first.created_at.to_json

		get "/api/v1/invoices/find_all?created_at=#{created}"

		invoices = JSON.parse(response.body)
		created_ats = invoices.map { |invoice| invoice['created_at']}

		expect(response).to be_success
		expect(invoices.count).to eq(3)
		expect(created_ats.all? { |c| created.include?(c) }).to be true
	end

	it "finds all items by updated_at" do
		create_list(:invoice, 3)
		updated = Invoice.first.updated_at.to_json

		get "/api/v1/invoices/find_all?updated_at=#{updated}"

		invoices = JSON.parse(response.body)
		updated_ats = invoices.map { |invoice| invoice['updated_at']}

		expect(response).to be_success
		expect(invoices.count).to eq(3)
		expect(updated_ats.all? { |u| updated.include?(u) }).to be true
	end
end 