class CreateSneakers < ActiveRecord::Migration[7.0]
  def change
    create_table :sneakers do |t|
      t.string :name
      t.string :brand
      t.text :description
      t.decimal :price

      t.timestamps
    end
  end
end
