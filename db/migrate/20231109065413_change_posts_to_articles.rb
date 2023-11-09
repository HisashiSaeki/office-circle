class ChangePostsToArticles < ActiveRecord::Migration[6.1]
  def change
    rename_table :posts, :articles
  end
end
