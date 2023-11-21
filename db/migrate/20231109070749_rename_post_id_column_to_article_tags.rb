class RenamePostIdColumnToArticleTags < ActiveRecord::Migration[6.1]
  def change
    rename_column :article_tags, :post_id, :article_id
  end
end
