class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.string :title
      t.string :genre
      t.integer :score
      t.string :content

      t.timestamps
    end
  end
end
