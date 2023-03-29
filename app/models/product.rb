
class Product < ApplicationRecord
  belongs_to :user
  before_save :set_price
  has_many :invoice_items

  def set_price
    self.price = rand(400..800) if self.price.nil?
  end
end
