class Api::V1::ItemsController < ApplicationController
  def index
    # render json: Merchant.find(params[:merchant_id]).items
    render json: ItemSerializer.new(Merchant.find(params[:merchant_id]).items)
    
    # require 'pry'; binding.pry
  end
end
