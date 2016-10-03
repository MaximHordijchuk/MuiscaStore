class AddPositionToMainProducts < ActiveRecord::Migration
  def change
    add_column :main_products, :position, :integer
  end
end
