class Genre < ApplicationRecord
  # カテゴリーを通してポストを取得、上下させない
  has_many :categories
  has_many :posts, through: :categories, dependent: :destroy
end
