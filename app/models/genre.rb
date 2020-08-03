class Genre < ApplicationRecord
  has_many :posts, through: :categories, dependent: :destroy
end
