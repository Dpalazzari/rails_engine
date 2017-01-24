class Api::V1::Merchants::RandomController < ApplicationController
  def show
    id = Merchant.pluck(:id).sample
    render json: Merchant.find(id)
  end
end
