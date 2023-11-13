class RenameTitleColumnToNotices < ActiveRecord::Migration[6.1]
  def change
    rename_column :notices, :title, :body
  end
end
