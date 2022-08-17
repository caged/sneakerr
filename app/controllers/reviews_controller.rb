class ReviewsController < AuthedController
  before_action :set_sneaker
  before_action :set_review, only: %i[ show edit update destroy ]

  # GET /reviews or /reviews.json
  def index
    @reviews = @sneaker.reviews.order(:created_at)
  end

  # GET /reviews/1 or /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews or /reviews.json
  def create
    @review = @sneaker.reviews.new(review_params.merge(user_id: current_user.id))

    respond_to do |format|
      @review.save
      format.turbo_stream
    end
  end

  # PATCH/PUT /reviews/1 or /reviews/1.json
  def update
    if @review.update(review_params)
      render turbo_stream: turbo_stream.replace(@review, @review)
    else 
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /reviews/1 or /reviews/1.json
  def destroy
    @review.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@review) }
    end
  end

  private

    def set_sneaker
      @sneaker = Sneaker.find(params[:sneaker_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def review_params
      params.require(:review).permit(:user_id, :sneaker_id, :body, :rating)
    end
end
