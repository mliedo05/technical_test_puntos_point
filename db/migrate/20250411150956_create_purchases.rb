class CreatePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :purchases do |t|
      t.integer :quiantity
      t.integer :total_price
      t.references :product, foreign_key: true
      t.references :client, foreign_key: true

      t.timestamps
    end
  end
end
