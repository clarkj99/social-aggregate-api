class CreateCommentsses < ActiveRecord::Migration[6.0]
  def change
    create_table :commentsses do |t|
      t.string :message
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.datetime :commented_at

      t.timestamps
    end
  end
end
