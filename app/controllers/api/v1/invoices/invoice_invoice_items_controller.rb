class Api::V1::Invoices::InvoiceInvoiceItemsController < ApplicationController

	def index
		invoice = Invoice.find(params[:id])
		render json: invoice.invoice_items
	end

end