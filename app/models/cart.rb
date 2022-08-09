class Cart < ApplicationRecord
  belongs_to :user
  has_many :line_items, dependent: :destroy 
  has_many :sneakers, through: :line_items 

  def sneaker_count(sneaker)
    line_items.find_by(sneaker_id: sneaker.id)&.quantity || 0
  end

  def add_sneaker(sneaker)
    item = find_item(sneaker)
    if item 
      item.increment(:quantity)
    else 
      item = line_items.build(sneaker_id: sneaker.id, quantity: 1)
    end

    item
  end

  def remove_sneaker(sneaker)
    item = find_item(sneaker)
    if item 
      item.decrement(:quantity) if item.quantity > 0 
    end 
    item.destroy if item.quantity == 0 
    item
  end

  def total_price 
    line_items.sum(&:total_price)
  end

  private 
  def find_item(sneaker)
    line_items.find_by(sneaker_id: sneaker.id)
  end
end
