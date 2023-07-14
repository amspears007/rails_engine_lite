class Api::V1::ItemsSearchController < ApplicationController
  def search
    if params[:name].present?
      found_item = Item.find_item_by_name_search(params[:name])
      render json: ItemSerializer.new(found_item)
     
    else
      render json: item.errors, status: 404

    end
 
  end
end



