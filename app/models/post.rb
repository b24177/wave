class Post < ApplicationRecord
  belongs_to :artist
  has_many :contents
end
