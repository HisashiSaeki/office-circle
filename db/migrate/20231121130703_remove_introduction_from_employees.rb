class RemoveIntroductionFromEmployees < ActiveRecord::Migration[6.1]
  def change
    remove_column :employees, :introduction, :text
  end
end
