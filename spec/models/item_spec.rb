require "rails_helper"

RSpec.describe Item, type: :model do
  before(:each) do
    @merchant1 = Merchant.create(name: "Amy")
    @merchant2 = Merchant.create(name: "Vivian")
    @merchant3 = Merchant.create(name: "Penny")
    @merchant4 = Merchant.create(name: "Amanda")

    @item1 = @merchant1.items.create!(name: "Rubber Chicken", description: "Its funny and bouncy", unit_price: 10.0)
    @item2 = @merchant1.items.create!(name: "Actual Chicken", description: "It clucks", unit_price: 25.0)
    @item3 = @merchant2.items.create!(name: "Purple Paint", description: "Its color is purple", unit_price: 15.12)
    @item4 = @merchant2.items.create!(name: "Paint Brush", description: "You paint with it", unit_price: 5.0)
    @item5 = @merchant2.items.create!(name: "Markers", description: "many colors", unit_price: 3.12)
    @item6 = @merchant3.items.create!(name: "Orange Paint", description: "Its color is orange", unit_price: 10.12)

  end
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:merchant_id) }
  end
  
  describe "relationships" do
    it { should belong_to(:merchant)}
    it { should have_many(:invoice_items)}
    it {should have_many(:invoices).through(:invoice_items)}
  end

  describe "it finds a single item by name in case-insensitive alphabetical order if multiple matches are found" do
    it "::find_item_by_name" do
    
      expect(Item.find_item_by_name_search("rubber")).to eq(@item1)
      expect(Item.find_item_by_name_search("paint")).to eq(@item6)
      expect(Item.find_item_by_name_search("chicken")).to eq(@item2)
      expect(Item.find_item_by_name_search("mar")).to eq(@item5)
      expect(Item.find_item_by_name_search("fun")).to eq(nil)
    end
  end

  describe "It finds an item by the lowest/minimum price" do
    it "::find_item_by_min_price" do

    expect(Item.find_item_by_min_price(4.99)).to eq(@item5)
    end
  end
end