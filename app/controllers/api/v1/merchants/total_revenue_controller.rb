class Api::V1::Merchants::TotalRevenueController < ApplicationController
  def show
    render json: Merchant, date: params[:date], serializer: TotalRevenueSerializer
  end
end
