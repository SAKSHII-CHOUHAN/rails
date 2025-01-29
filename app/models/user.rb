class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: true
  validates :restaurant_name, presence: true
  validates :location, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :contact, presence: true
end
