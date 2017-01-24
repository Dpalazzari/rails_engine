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
end 