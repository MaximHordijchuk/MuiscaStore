class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :trackable,
         :rememberable, :validatable
end
