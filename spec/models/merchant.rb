require "rails_helper"

Rspec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many (:items)}
  end

end