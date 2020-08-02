class Contact < ApplicationRecord
  belongs_to :user

  attachment :image

end
