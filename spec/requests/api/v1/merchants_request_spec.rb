require "rails_helper"

RSpec.describe "Merchants API" do 
  describe "All Merchants API Request" do
    it "sends a list of merchants" do
      create_list(:merchant, 3)
      get "/api/v1/merchants"

      expect(response).to be_successful
      expect(response.status).to eq(200)
    

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants[:data][0]).to be_a(Hash)
      expect(merchants[:data][1][:type]).to eq("merchant")
      expect(merchants[:data][1].count).to eq(3)
      expect(merchants[:data][1][:attributes]).to have_key(:name)
      # expect(merchants[:data][0][:id]).to be_an(Integer)

    merchants[:data].each do |merchant|
      expect(merchant). to have_key(:id)
      expect(merchant[:id].to_i).to be_an(Integer)
      expect(merchant). to have_key(:attributes)
      expect(merchant[:attributes]).to be_an(Hash)
    end
  end
end

  it "finds a single merchant by its id" do
  
    id = create(:merchant).id
    get "/api/v1/merchants/#{id}"
    
    merchant = JSON.parse(response.body, symbolize_names: true)
    
    expect(response).to be_successful
    expect(response.status).to eq(200)

    expect(merchant[:data]).to have_key(:id)
    expect(merchant[:data]).to have_key(:type)
    expect(merchant[:data]).to have_key(:attributes)
    expect(merchant[:data].count).to eq(3)
    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
  end

  it "return items associated with a specific merchant" do
    merchant1 = Merchant.create(name: "Amy")
    item1 = merchant1.items.create!(name: "Rubber Chicken", description: "Its funny and bouncy", unit_price: 10.0)
    item2 = merchant1.items.create!(name: "Actual Chicken", description: "It clucks", unit_price: 25.0)

    # require 'pry'; binding.pry
    get "/api/v1/merchants/#{merchant1.id}/items"

    expect(response).to be_successful
    
  end
end