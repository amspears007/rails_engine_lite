class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    item = Item.new(item_params)
    if item.save
    render json: ItemSerializer.new(Item.create!(item_params)), status: 201
#not sure about this error message
    else
      render json: { error: item.errors.full_messages }
    end
  end

  def update
    render json: ItemSerializer.new(Item.update(params[:id], item_params))
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
   