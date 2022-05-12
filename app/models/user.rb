class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true

  has_many :favorite_recipes
  has_many :recipes, through: :favorite_recipes
  has_many :favorite_ingredients
  has_many :ingredients, through: :favorite_ingredients
end
