class ChangeProductPriceType < ActiveRecord::Migration[7.0]
  def up
    change_column :products, :price, :float, default: 0.0
  end
  def down
    change_column :products, :price, :integer, default: 0
  end
end
