class AddAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean, default: false

    User.create!(email: 'admin@example.com', password: 'password', admin: true)
  end
end
