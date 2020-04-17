class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :github_username
      t.datetime :registered_at

      t.timestamps
    end
  end
end
