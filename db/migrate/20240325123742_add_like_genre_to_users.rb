class AddLikeGenreToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :like_genre, :string
  end
end
