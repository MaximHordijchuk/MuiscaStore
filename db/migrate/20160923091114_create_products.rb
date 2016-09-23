class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :article
      t.string :name
      t.decimal :price, precision: 5, scale: 2
      t.references :category, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
