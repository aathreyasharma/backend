require 'rails_helper'

RSpec.describe Product, type: :model do

  let(:user) { FactoryBot.create(:user) }

  describe "successfully" do
    it "creates a product with a user" do
      Product.create(
        name: Faker::Commerce.name,
        price: Faker::Commerce.price,
        user: user
      )
      expect(Product.count).to eq(1)
    end
  end

  describe "failed" do
    it "to create a product without a user" do
      Product.create(
        name: Faker::Commerce.name,
        price: Faker::Commerce.price
      )
      expect(Product.count).to eq(0)
    end
  end
end
