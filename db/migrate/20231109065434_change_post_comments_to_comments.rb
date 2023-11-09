class ChangePostCommentsToComments < ActiveRecord::Migration[6.1]
  def change
    rename_table :post_comments, :comments
  end
end
