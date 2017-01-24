class Api::V1::RandomMerchantController < ApplicationController
  def show
    id = Merchant.pluck(:id).sample
    render json: Merchant.find(id)
  end
end
