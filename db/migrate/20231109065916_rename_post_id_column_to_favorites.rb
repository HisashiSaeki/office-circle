class RenamePostIdColumnToFavorites < ActiveRecord::Migration[6.1]
  def change
    rename_column :favorites, :post_id, :article_id
  end
end
