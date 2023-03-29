class UserSerializer < BaseSerializer
  attributes :name, :age, :email
  has_many :products
end
