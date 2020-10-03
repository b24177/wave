class Content < ApplicationRecord
  belongs_to :post
  has_one_attached :photo
end
