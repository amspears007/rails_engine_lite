class Api::V1::ItemsSearchController < ApplicationController
  def search
    if params[:name].empty? || params[:name].nil?
      render json: { error: "No content" }, status: 404
    elsif Item.find_item_by_name_search(params[:name]) == nil
      render json: { data: [] }
    else 
      found_item = Item.find_item_by_name_search(params[:name])
      render json: ItemSerializer.new(found_item)
    end


    # if params[:name].present?
    #   # require 'pry'; binding.pry
    #   found_item = Item.find_item_by_name_search(params[:name])
    #   render json: ItemSerializer.new(found_item)
    # else
    #   render json: item.errors, status: 404

    # end
  end
end



