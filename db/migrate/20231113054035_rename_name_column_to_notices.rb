class RenameNameColumnToNotices < ActiveRecord::Migration[6.1]
  def change
    rename_column :notices, :name, :title
  end
end
