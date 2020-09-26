class Post < ApplicationRecord
  belongs_to :artist
  has_many :contents
  has_one_attached :photo
end
