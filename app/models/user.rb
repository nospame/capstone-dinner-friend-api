class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true

  has_many :favorite_recipes
  has_many :recipes, through: :favorite_recipes
end
