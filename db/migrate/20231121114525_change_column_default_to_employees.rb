class ChangeColumnDefaultToEmployees < ActiveRecord::Migration[6.1]
  def change
    change_column_default :employees, :introduction, from: nil, to: "自己紹介文を設定しましょう！"
  end
end
