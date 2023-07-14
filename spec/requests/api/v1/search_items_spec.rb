require "rails_helper"

RSpec.describe "Items Search API" do
  before(:each) do
    @merchant1 = Merchant.create(name: "Amy")
    @merchant2 = Merchant.create(name: "Vivian")
    @merchant3 = Merchant.create(name: "Penny")
    @merchant4 = Merchant.create(name: "Amanda")


    @item1 = @merchant1.items.create!(name: "Rubber Chicken", description: "Its funny and bouncy", unit_price: 10.0)
    @item2 = @merchant1.items.create!(name: "Actual Chicken", description: "It clucks", unit_price: 25.0)
    @item3 = @merchant2.items.create!(name: "Paint Brush", description: "You paint with it", unit_price: 4.99)
    @item4 = @merchant2.items.create!(name: "Purple Paint", description: "Its color is purple", unit_price: 15.12)
    @item5 = @merchant2.items.create!(name: "Markers", description: "many colors", unit_price: 3.12)
    @item6 = @merchant3.items.create!(name: "Orange Paint", description: "Its color is orange", unit_price: 4.50)
  end

  describe "Happy Path it searches for a single item that matches a search term" do
    it "GET /api/vi/items/find" do
      get "/api/v1/items/find?name=mark"
      expect(response).to be_successful
      expect(response.status).to eq(200)

      search_result = JSON.parse(response.body, symbolize_names: true)
      expect(search_result[:data][:type]).to be_a(String)
      expect(search_result[:data][:type]).to eq("item")
      expect(search_result[:data][:attributes]).to be_a(Hash)
      expect(search_result[:data][:attributes][:name]).to eq("Markers")
    end
  end

  describe "Sad path returns an empty array" do
    it "GET /api/vi/items/find" do
      get "/api/v1/items/find?name=sunny"
      expect(response).to be_successful
      expect(response.status).to eq(200)

      search_result = JSON.parse(response.body, symbolize_names: true)
      expect(search_result[:data]).to eq([])
    end
  end

  describe "Sad path no name param is empty" do
    it "GET /api/vi/items/find" do
      get "/api/v1/items/find?name="""
      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      search_result = JSON.parse(response.body, symbolize_names: true)
      expect(search_result).to be_a(Hash)
      expect(search_result).to have_key(:error)
      expect(search_result).to have_value("No content")
    end
  end

  describe "Find single item by minimum price" do
    xit "GET /api/v1/items/find?min_price=4.99" do
      get "/api/v1/items/find?min_price=4.99"

      expect(response).to be_successful
      expect(response.body).to eq(200)
    end
  end
end