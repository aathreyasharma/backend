class User < ApplicationRecord
  has_many :products
  before_save :create_email, :set_age

  has_many :invoices

  def create_email

    binding.pry

    self.email = "#{self.name}@gmail.com" if self.email.nil?
  end

  def set_age
    self.age = rand(10..50) if self.age.nil?
  end

end
