json.extract! review, :id, :user_id, :sneaker_id, :body, :rating, :created_at, :updated_at
json.url review_url(review, format: :json)
