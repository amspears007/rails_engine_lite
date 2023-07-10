require "rails_helper"

describe "All Merchants API Request" do
  it "sends a list of merchants" do
    get "/api/v1/merchants"

    expect(response).to be_successful

  end
end