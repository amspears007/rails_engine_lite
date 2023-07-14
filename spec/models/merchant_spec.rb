require "rails_helper"

RSpec.describe Merchant, type: :model do
  before(:each) do
    @merchant1 = Merchant.create(name: "Amy")
    @merchant2 = Merchant.create(name: "Vivian")
    @merchant3 = Merchant.create(name: "Penny")
    @merchant4 = Merchant.create(name: "Amanda")
    @merchant5 = Merchant.create(name: "Toddy")


    @item1 = @merchant1.items.create!(name: "Rubber Chicken", description: "Its funny and bouncy", unit_price: 10.0)
    @item2 = @merchant1.items.create!(name: "Actual Chicken", description: "It clucks", unit_price: 25.0)
    @item3 = @merchant2.items.create!(name: "Purple Paint", description: "Its color is purple", unit_price: 15.12)
    @item4 = @merchant2.items.create!(name: "Paint Brush", description: "You paint with it", unit_price: 5.0)
    @item5 = @merchant2.items.create!(name: "Markers", description: "many colors", unit_price: 3.12)
    @item6 = @merchant3.items.create!(name: "Orange Paint", description: "Its color is orange", unit_price: 10.12)

  end
  describe "validations" do
    it { should validate_presence_of(:name) } 
  end
  describe "relationships" do
    it { should have_many(:items)}
  end

  describe "It returns all merchants in a name search in case-insensitive alphabetical order if multiple matches are found" do
    it "::find_all_merchants_by_name" do
      expect(Merchant.find_all_merchants_by_name("am")).to eq([@merchant4, @merchant1])
      expect(Merchant.find_all_merchants_by_name("y")).to eq([@merchant1, @merchant3, @merchant5])
      expect(Merchant.find_all_merchants_by_name("chicken")).to eq([])
    end
  end
end