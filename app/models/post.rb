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
      binding.pry
      return find(Comment.group(:post_id).order(Arel.sql('count(post_id)desc')).pluck(:post_id))
    when "less_comment"
      return find(Comment.group(:post_id).order(Arel.sql('count(post_id)asc')).pluck(:post_id))
    when "many_favorite"
      return find(Favorite.group(:post_id).order(Arel.sql('count(post_id)desc')).pluck(:post_id))
    end
  end

end
