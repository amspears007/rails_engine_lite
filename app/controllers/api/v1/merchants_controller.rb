class Api::V1::MerchantsController < ApplicationController
  def index
    render json: Merchant.all
    # require 'pry'; binding.pry
  end

end