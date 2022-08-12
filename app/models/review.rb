class Review < ApplicationRecord
  belongs_to :user
  belongs_to :sneaker

  validates :body, presence: true
end
