class CreateRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :ratings do |t|
      t.integer :rating
      t.references :rater, null: false
      t.references :user, null: false, foreign_key: true
      t.datetime :rated_at

      t.timestamps
    end
  end
end
