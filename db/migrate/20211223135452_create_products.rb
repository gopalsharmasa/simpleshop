class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.string :image_url
      t.float :price
      t.string :sku
      t.integer :stock
      t.references :shop, null: false, foreign_key: true

      t.timestamps
    end
  end
end
