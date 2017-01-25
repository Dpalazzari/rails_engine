class Api::V1::Invoices::InvoiceCustomerController < ApplicationController

	def show
		invoice = Invoice.find(params[:id])
		render json: invoice.customer
	end

end