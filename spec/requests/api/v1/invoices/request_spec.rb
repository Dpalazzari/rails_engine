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

	it "finds all invoices by status" do
		invoices = create_list(:invoice, 3)
		db_invoice = invoices.first

		get "/api/v1/invoices/find_all?status=#{db_invoice.status}"

		invoice = JSON.parse(response.body).first

		expect(response).to be_success
		verify_invoice_attributes(invoice, db_invoice)
	end

	it "finds all invoices by status regardless of case" do
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

	it "finds all invoices by created_at" do
		create_list(:invoice, 3, created_at: Time.now)
		created = Invoice.first.created_at.to_json

		get "/api/v1/invoices/find_all?created_at=#{created}"

		expect(response).to be_success

		invoices = JSON.parse(response.body)
		db_invoices = Invoice.where(id: invoices.map { |invoice| invoice['id'] })
		created_ats = db_invoices.map { |invoice| invoice.created_at}

		expect(invoices.count).to eq(3)
		expect(created_ats.all? { |c| c == created }).to be true
	end

	it "finds all invoices by updated_at" do
		create_list(:invoice, 3, updated_at: Time.now)
		updated = Invoice.first.updated_at.to_json

		get "/api/v1/invoices/find_all?updated_at=#{updated}"

		invoices = JSON.parse(response.body)
		db_invoices = Invoice.where(id: invoices.map { |invoice| invoice['id'] })
		updated_ats = db_invoices.map { |invoice| invoice.updated_at}

		expect(response).to be_success
		expect(invoices.count).to eq(3)
		expect(updated_ats.all? { |u| u == updated }).to be true
	end

	it "finds a random invoice" do
		create_list(:invoice, 100)

		get '/api/v1/invoices/random'

		invoice_1 = JSON.parse(response.body)
		db_invoice_1 = Invoice.find(invoice_1['id'])

		get '/api/v1/invoices/random'

		invoice_2 = JSON.parse(response.body)
		db_invoice_2 = Invoice.find(invoice_2['id'])

		expect(invoice_1).to_not eq(invoice_2)
	end
end
