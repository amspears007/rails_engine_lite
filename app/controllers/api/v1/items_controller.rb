class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    render json: ItemSerializer.new(Item.create!(item_params)), status: 201
  end

  def update
    render json: ItemSerializer.new(Item.update(params[:id], item_params))
  end
  

  private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
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
    # require 'pry'; binding.pry