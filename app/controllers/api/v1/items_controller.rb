class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    begin 
      item = Item.find(params[:id])
      render json: ItemSerializer.new(item)
    rescue 
      render json: { error: "Item not found" }, status: 404
      # require 'pry'; binding.pry
    end
  end

  def create
    item = Item.new(item_params)
    if item.save
      render json: ItemSerializer.new(item), status: 201
      #not sure about this error message
    else
      render json: item.errors, status: 404
    end
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    if item.save
      render json: ItemSerializer.new(item), status: 201
    else
      render json: item.errors, status: 404
    end
    # render json: ItemSerializer.new(Item.update(params[:id], item_params))
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
  end
  

  private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end

  def validates_merchant
    # if item_params(merchant_id) != nil
    # require 'pry'; binding.pry
    #some code
  end
end










# def create
  #   item = Item.new(item_params)
  #   if item.save
  #     render json: ItemSerializer.new(item), status: :created
  #   else
  #     render json: { error: item.errors.full_messages }, status: :unprocessable_entity
  #   end
  # end

#def update
   # item = Item.find(params[:id])
    # item.update!(item_params)
    # render json: ItemSerializer.new(item)
   