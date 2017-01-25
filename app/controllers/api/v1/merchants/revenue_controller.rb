class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    merchant = Merchant.find(params[:id])
    render json: merchant, date: params[:date], serializer: RevenueSerializer
  end
end
