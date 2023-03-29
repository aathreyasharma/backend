class ProductSerializer < BaseSerializer

  attr_accessor :name, :price
  belongs_to :user

end
