class Api::V1::ItemsMerchantController < ApplicationController
  def index
    # item = Item.find(params[:item_id]).merchant
    # require 'pry'; binding.pry
    render json: MerchantSerializer.new(Item.find(params[:item_id]).merchant)
  end
end