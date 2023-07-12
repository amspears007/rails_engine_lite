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
end