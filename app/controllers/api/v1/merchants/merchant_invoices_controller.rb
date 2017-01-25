class Api::V1::Merchants::MerchantInvoicesController < ApplicationController

	def index
		merchant = Merchant.find(params[:id])
		render json: merchant.invoices
	end

end