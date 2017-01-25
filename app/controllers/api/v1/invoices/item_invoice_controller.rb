class Api::V1::Invoices::ItemInvoiceController < ApplicationController

	def index
		invoice = Invoice.find(params[:id])
		render json: invoice.items
	end

end