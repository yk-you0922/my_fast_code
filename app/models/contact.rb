class Contact < ApplicationRecord
  belongs_to :user

  attachment :image

  enum is_support_status: [:"対応待ち", :"対応中", :"対応済み"]

end
