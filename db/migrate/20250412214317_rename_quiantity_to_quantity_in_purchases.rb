class RenameQuiantityToQuantityInPurchases < ActiveRecord::Migration[5.2]
  def change
    rename_column :purchases, :quiantity, :quantity
  end
end
