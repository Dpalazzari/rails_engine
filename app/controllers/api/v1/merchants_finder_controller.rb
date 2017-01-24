class Api::V1::MerchantsFinderController < ApplicationController
  def show
    render json: Merchant.find_by(merchant_params)
  end

  def index
    render json: Merchant.where(merchant_params)
  end

  private

  def merchant_params
    params.permit(:name, :id, :created_at, :updated_at)
  end
end
