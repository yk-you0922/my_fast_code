class Genre < ApplicationRecord
  has_many :categorites, dependent: :destroy
end
