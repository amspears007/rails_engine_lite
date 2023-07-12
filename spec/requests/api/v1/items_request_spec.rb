require "rails_helper"

RSpec.describe "Items API" do
  describe "return all items" do
    it "exposes the endpoint for all items" do
      merchant1 = Merchant.create(name: "Amy")
      item1 = merchant1.items.create!(name: "Rubber Chicken", description: "Its funny and bouncy", unit_price: 10.0)
      item2 = merchant1.items.create!(name: "Actual Chicken", description: "It clucks", unit_price: 25.0)
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
    # require 'pry'; binding.pry
    end
  end
end