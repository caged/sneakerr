class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :sneaker, null: false, foreign_key: true
      t.text :body
      t.integer :rating, unsigned: true, default: 0

      t.timestamps
    end
  end
end
