class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  attachment :image

  # バリデーション
  validates :body, presence: true, length:{maximum: 140}

end
