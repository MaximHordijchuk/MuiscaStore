class CreateMainProducts < ActiveRecord::Migration
  def change
    create_table :main_products do |t|
      t.references :product, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
