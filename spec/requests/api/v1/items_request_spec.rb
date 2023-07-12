require "rails_helper"

RSpec.describe "Items API" do
  describe "return all items" do
    xit "exposes the endpoint for all items" do
    get "/api/v1/items"

    expect(response).to be_successful
    expect(response.status).to eq(200)

    items = JSON.parse(response.body, symbolize_names: true)
    end
  end
end