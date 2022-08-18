class Review < ApplicationRecord
  belongs_to :user
  belongs_to :sneaker

  validates :body, presence: true

  after_destroy_commit -> { 
    broadcast_remove_to [sneaker, :reviews], target: self 
    broadcast_update_to [sneaker, :reviews], 
      target: dom_id(sneaker, :review_count),
      html: sneaker.reviews.count
  }
  after_create_commit -> {
    broadcast_append_later_to [sneaker, :reviews], 
      partial: 'reviews/simple_review',
      target: dom_id(sneaker, :reviews),
      locals: { review: self }

    broadcast_update_later_to [sneaker, :reviews], 
      target: dom_id(sneaker, :review_count),
      html: sneaker.reviews.count      
  }

  after_update_commit -> {
    broadcast_replace_later_to [sneaker, :reviews], 
      partial: 'reviews/simple_review',
      locals: { review: self }
  }
end
