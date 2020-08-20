class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :comment_favorites, dependent: :destroy

  attachment :image

  
  # バリデーション
  validates :body, presence: true, length:{maximum: 140}
  
  # ユーザーがそのコメントをお気に入りしているか判断する
  def comment_favorited_by?(user)
    comment_favorites.where(user_id: user.id).exists?
  end

end
