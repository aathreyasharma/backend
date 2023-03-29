class Invoice < ApplicationRecord
  has_many :invoice_items, dependent: :delete_all
  belongs_to :user

  before_save :calculate_total
  after_commit :create_invoice_number, on: :create

  private

  def create_invoice_number
    self.invoice_number = "INV-#{self.user.id}-#{self.id}"
    self.save
  end

  def calculate_total
    self.total_price =  self.invoice_items.sum(:total_price)
  end


end
