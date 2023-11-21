class CreateNotices < ActiveRecord::Migration[6.1]
  def change
    create_table :notices do |t|
      t.integer :group_id, null: false
      t.string :name, null: false
      t.text :title, null: false
      t.timestamps
    end
  end
end
