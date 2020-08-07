class Contact < ApplicationRecord
  belongs_to :user

  attachment :image

  enum is_support_status: [:"対応待ち", :"対応中", :"対応済み"]

  # バリデーション
  validates :name, presence: true
  validates :email, presence: true
  validates :title, presence: true
  validates :body, presence: true

end
