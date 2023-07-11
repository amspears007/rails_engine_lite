require "rails_helper"

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