class LineItem < ApplicationRecord
  belongs_to :sneaker
  belongs_to :cart

  def total_price 
    sneaker.price * quantity
  end
end
