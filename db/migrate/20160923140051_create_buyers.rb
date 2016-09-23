class CreateBuyers < ActiveRecord::Migration
  def change
    create_table :buyers do |t|
      t.string :login
      t.string :password_digest

      t.timestamps null: false
    end
  end
end
