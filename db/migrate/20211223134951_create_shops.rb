class CreateShops < ActiveRecord::Migration[6.1]
  def change
    create_table :shops do |t|
      t.string :title
      t.references :region, null: false, foreign_key: true

      t.timestamps
    end
  end
end
