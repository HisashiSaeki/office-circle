class CreateActivities < ActiveRecord::Migration[6.1]
  def change
    create_table :activities do |t|
      t.references :subject, polymorphic: true
      t.references :employee, foreign_key: true
      t.integer :action_type, null: false
      t.boolean :checked

      t.timestamps
    end
  end
end
