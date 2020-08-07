class Genre < ApplicationRecord
  # カテゴリーを通してポストを取得、上下させない
  has_many :categories
  has_many :posts, through: :categories, dependent: :destroy

  # バリデーション
  validates :name, presence: true
end
