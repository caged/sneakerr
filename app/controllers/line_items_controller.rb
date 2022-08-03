class LineItemsController < AuthedController
  before_action :set_sneaker

  def update 
    @line_item = @cart.add_sneaker(@sneaker)
    @line_item.save
  end

  def destroy 
    @line_item = @cart.remove_sneaker(@sneaker)
    @line_item.save
  end

  private 

  def set_sneaker 
    @sneaker = Sneaker.find(params[:sneaker_id])
  end
end
