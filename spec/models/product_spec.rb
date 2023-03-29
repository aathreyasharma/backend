require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "a Product" do
    let(:user) { FactoryBot.create(:user) }
    it "creates a product" do
      Product.create(
        name: Faker::Commerce.name,
        price: Faker::Commerce.price,
        user: user
      )
      expect(Product.count).to eq(1)
    end

    it "does not creates a product without a user" do
      Product.create(
        name: Faker::Commerce.name,
        price: Faker::Commerce.price
      )
      expect(Product.count).to eq(0)
    end
  end
end
