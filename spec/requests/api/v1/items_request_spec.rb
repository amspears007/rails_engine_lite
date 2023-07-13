require "rails_helper"

RSpec.describe "Items API" do
  before(:each) do
    @merchant1 = Merchant.create(name: "Amy")
    @item1 = @merchant1.items.create!(name: "Rubber Chicken", description: "Its funny and bouncy", unit_price: 10.0)
    @item2 = @merchant1.items.create!(name: "Actual Chicken", description: "It clucks", unit_price: 25.0)
  end
  describe "return all items" do
    it "exposes the endpoint for all items" do
      get "/api/v1/items"

    expect(response).to be_successful
    expect(response.status).to eq(200)

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data]).to be_a(Array)
    expect(items[:data].count).to eq(2)
    expect(items[:data][1]).to be_a(Hash)
    expect(items[:data][1]).to have_key(:id)
    expect(items[:data][1][:attributes][:description]).to eq("It clucks")
    expect(items[:data][1][:attributes][:unit_price]).to eq(25.0)
    end
  end
  
  describe "returns one item by id" do
    it "finds item by id '/api/v1/items/:item_id" do
      id = @item2.id
      get "/api/v1/items/#{@item2.id}"
      
      item = JSON.parse(response.body, symbolize_names: true)
      
    expect(response).to be_successful
    expect(response.status).to eq(200)

    expect(item[:data]).to have_key(:id)
    expect(item[:data]).to have_key(:type)
    expect(item[:data]).to have_key(:attributes)
    expect(item[:data][:attributes]).to have_key(:name)
    expect( item[:data][:type]).to eq("item")
    expect(item[:data][:attributes][:name]).to be_a(String)
    end
  end

  describe 'sad paths for finding an item' do
    xit "will gracefully handle if a book id doesn't exist" do
      get "/api/v1/items/#{6}"

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      data = JSON.parse(response.body, symbolize_names: true)
      
      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:status]).to eq("404")
      expect(data[:errors].first[:title]).to eq("Couldn't find Book with 'id'=1")
    end
  end

  describe "It creates an item" do
    it "'post api/v1/items" do 
      item_params = {
        name: "Cone",
        description: "Orange and Pointy",
        unit_price: 15.2,
        merchant_id: @merchant1.id
        
        }
       
        post "/api/v1/items", params: {item: item_params}
     
      created_item = Item.last

      expect(response).to be_successful
      expect(response.status).to eq(201)
      item = JSON.parse(response.body, symbolize_names: true)

      expect(created_item.name).to eq(item_params[:name])
      expect(created_item.description).to eq(item_params[:description])
      expect(created_item.unit_price).to eq(item_params[:unit_price])
      expect(created_item.merchant_id).to eq(item_params[:merchant_id])
    end
  end

  describe "Sad path for creating an item" do
    it "'post api/v1/items" do 
      item_params = {
        name: "",
        description: "Orange and Pointy",
        unit_price: 15.2,
        merchant_id: @merchant1.id
        
        }
       
        post "/api/v1/items", params: {item: item_params}
    #  require 'pry'; binding.pry
      created_item = Item.last

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      item = JSON.parse(response.body, symbolize_names: true)
      expect(item[:name][0]).to eq("can't be blank")
      end
    end

  describe "Delete item" do
    it "can destroy an item" do
    @item3 = @merchant1.items.create!(name: "Fried Chicken", description: "Its delicious", unit_price: 12.0)
    expect(Item.count).to eq(3)
    
    delete "/api/v1/items/#{@item3.id}"
    expect(response).to be_successful
    expect(response.status).to eq(204)
    expect(Item.count).to eq(2)
    end
  end

  describe "It can update an item 'patch api/v1/items/:item_id' " do
    it "can update an existing item" do
      id = @item1.id
      previous_description = Item.last.description

      item_params = { name: "Rubber Chicken", 
                      description: "Its funny and rubbery",
                      unit_price: 10.0,
                      merchant_id: @merchant1.id
                     
                    }
      headers = {"CONTENT_TYPE" => "application/json"}
      patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})

      item = Item.find_by(id: id)
    
      expect(response).to be_successful
      updated_item = JSON.parse(response.body, symbolize_names: true)

      expect(item.description).to_not eq(previous_description)
      expect(item.description).to eq("Its funny and rubbery")
    end
  end

  describe "Sad path to update an item" do
    it "won't update if params aren't filled out" do
      id = @item1.id

      item_params = { name: "Rubber Chicken", 
                      description: "",
                      unit_price: 10.0,
                      merchant_id: @merchant1.id
                     
                    }
      headers = {"CONTENT_TYPE" => "application/json"}
      patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})

      expect(response).to_not be_successful

    end
  end

  describe "Item Merchant API " do
    it "'/api/v1/items/:item_id/merchant'" do
      get "/api/v1/items/#{@item1.id}/merchant"

      expect(response).to be_successful
      expect(response.status).to eq(200)
      item = JSON.parse(response.body, symbolize_names: true)

    end
  end
end