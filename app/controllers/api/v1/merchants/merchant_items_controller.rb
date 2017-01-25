class Api::V1::Merchants::MerchantItemsController < ApplicationController

	def index
		merchant = Merchant.find(params[:id])
		render json: merchant.items
	end

end