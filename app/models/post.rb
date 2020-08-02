class Post < ApplicationRecord
  belongs_to :user
  has_many :favorites
  has_many :comments
  has_many :categories

  attachment :image

end
