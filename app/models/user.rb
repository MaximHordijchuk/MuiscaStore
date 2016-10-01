class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :trackable,
         :rememberable, :validatable

  has_many :orders, dependent: :destroy
end
