class ChangeColumnDefaultToEmployeesTheSecondTime < ActiveRecord::Migration[6.1]
  def change
    change_column_default :employees, :introduction, nil
  end
end
