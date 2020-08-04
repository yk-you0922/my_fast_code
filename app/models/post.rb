class Post < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  # カテゴリーを通してジャンルを取得するので、上下させない
  has_many :categories
  has_many :genres, through: :categories

  attachment :image
end
