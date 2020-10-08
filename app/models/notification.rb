class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :post

  scope :unread, -> () {where(read_at: nil)}
end
