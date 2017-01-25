class Api::V1::InvoiceItems::SearchController < ApplicationController

	def show
		render json: InvoiceItem.find_by(invoice_item_params)
	end

	def index
		render json: InvoiceItem.where(invoice_item_params)
	end

	private

	def invoice_item_params
		params[:unit_price] = (params[:unit_price].to_f * 100.00).to_s if params[:unit_price] &&
			params[:unit_price].include?('.')
		params.permit(:id, :invoice_id, :item_id, :quantity, :unit_price, :created_at, :updated_at)
	end

end
