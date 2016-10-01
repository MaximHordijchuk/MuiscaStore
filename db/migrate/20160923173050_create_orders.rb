class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :name
      t.string :surname
      t.string :address
      t.string :phone
      t.string :card_no
      t.string :card_type
      t.integer :expire_month
      t.integer :expire_year
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
