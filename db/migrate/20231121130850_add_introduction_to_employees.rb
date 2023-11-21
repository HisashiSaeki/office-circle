class AddIntroductionToEmployees < ActiveRecord::Migration[6.1]
  def change
    add_column :employees, :introduction, :text
  end
end
