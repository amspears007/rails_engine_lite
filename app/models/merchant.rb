class Merchant < ApplicationRecord
  has_many :items
  validates_presence_of :name

  def self.find_all_merchants_by_name(name)
    where("name ILIKE ?", "%#{name}%").order(:name)
  end
end