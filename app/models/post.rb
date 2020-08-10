class Post < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  # カテゴリーを通してジャンルを取得するので、上下させない
  has_many :categories, dependent: :destroy
  has_many :genres, through: :categories

  attachment :image

  # バリデーション
  validates :title, presence: true
  validates :image, presence: true
  validates :body, presence: true
  validates :genres, presence: true
  validates :closed_on, presence: true

  # ユーザーがその投稿をお気に入りしているか判断する
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

end
