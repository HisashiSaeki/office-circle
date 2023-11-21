class ChangePostTagsToArticleTags < ActiveRecord::Migration[6.1]
  def change
    rename_table :post_tags, :article_tags
  end
end
