class Api::V1::MerchantsSearchController < ApplicationController
  def search
    if params[:name].empty? || params[:name].nil?
      render json: { error: "No content" }, status: 404
    elsif Merchant.find_all_merchants_by_name(params[:name]) == []
      render json: { data: [] }
    else 
      found_merchant = Merchant.find_all_merchants_by_name(params[:name])
      render json: MerchantSerializer.new(found_merchant)
    end
  end
end