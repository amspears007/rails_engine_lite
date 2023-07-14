class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates_presence_of :name,
                        :unit_price,
                        :description,
                        :merchant_id

  def self.find_item_by_name_search(name)
    where("name ILIKE ?", "%#{name}%").order(:name).first
  end

  def self.find_item_by_min_price(min_price)
    # require 'pry'; binding.pry
    where("unit_price < #{min_price}").order(:unit_price).first
  end
end