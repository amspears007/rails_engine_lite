require "rails_helper"

RSpec.describe " Search API" do
  before(:each) do
    @merchant1 = Merchant.create(name: "Amy")
    @merchant2 = Merchant.create(name: "Vivian")
    @merchant3 = Merchant.create(name: "Penny")
    @merchant4 = Merchant.create(name: "Amanda")

    @item1 = @merchant1.items.create!(name: "Rubber Chicken", description: "Its funny and bouncy", unit_price: 10.0)
    @item2 = @merchant1.items.create!(name: "Actual Chicken", description: "It clucks", unit_price: 25.0)
    @item3 = @merchant2.items.create!(name: "Paint Brush", description: "You paint with it", unit_price: 4.99)
    @item5 = @merchant2.items.create!(name: "Markers", description: "many colors", unit_price: 3.12)
    @item6 = @merchant3.items.create!(name: "Orange Paint", description: "Its color is orange", unit_price: 4.50)
  end

  describe "Happy Path it searches for all merchants that matches a name search" do
    it "GET /api/v1/merchants/find_all" do
      get "/api/v1/merchants/find_all?name=am"
      expect(response).to be_successful
      expect(response.status).to eq(200)

      search_result = JSON.parse(response.body, symbolize_names: true)
      expect(search_result[:data].count).to eq(2)
      names = search_result[:data].map do |data|
        data[:attributes][:name]
      end
      expect(names).to eq(["Amanda","Amy"])
      expect(search_result[:data][0][:type]).to eq("merchant")
      expect(search_result[:data][0][:attributes]).to be_a(Hash)
    end
  end

  describe "Sad path returns an empty array" do
    it "GET /api/vi/merchants/find_all" do
      get "/api/v1/merchants/find_all?name=sunny"
      expect(response).to be_successful
      expect(response.status).to eq(200)

      search_result = JSON.parse(response.body, symbolize_names: true)
      expect(search_result[:data]).to eq([])
    end
  end
end