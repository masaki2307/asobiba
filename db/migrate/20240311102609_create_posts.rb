class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      t.integer :genre_id, null: false
      t.integer :user_id, null: false
      t.text :introduction, null: false
      t.string :title, null: false
      t.float :review, null: false, default: 0
      t.timestamps
    end
  end
end
