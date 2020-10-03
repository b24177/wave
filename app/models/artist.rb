class Artist < ApplicationRecord
  has_one_attached :photo
  has_many :posts
end
