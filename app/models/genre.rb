class Genre < ApplicationRecord
  has_many :categories
  has_many :posts, through: :categories, dependent: :destroy
end
