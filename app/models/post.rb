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

  # 投稿一覧のソート定義
  def self.sort(selection)
    case selection
    when "new"
      return all.order(created_at: :DESC)
    when "old"
      return all.order(created_at: :ASC)
    when "commentable"
      return all.order(closed_on: :DESC)
    when "many_comment"
      return joins(:comments).group(:post_id).order('count(post_id) desc')
    when "many_favorite"
      return joins(:favorites).group(:post_id).order('count(post_id) desc')
    end
  end

end
