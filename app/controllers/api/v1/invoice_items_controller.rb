class Api::V1::InvoiceItemsController < ApplicationController

	def show
		render json: InvoiceItem.find(params[:id])
	end

	def index
		render json: InvoiceItem.all
	end

end