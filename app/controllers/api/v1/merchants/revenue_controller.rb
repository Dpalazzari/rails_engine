class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    merchant = Merchant.find(params[:id])
    revenue = merchant.revenue(params[:date])
    render json: { 'revenue' => revenue }
  end
end
