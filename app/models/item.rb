class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates_presence_of :name,
                        :unit_price,
                        :description,
                        :merchant_id

  def self.find_item_by_name_search(name)
    items = where("name ILIKE ?", "%#{name}%").order(:name).first
    
    return items unless items.nil?
    "No items match that search"
  end
end