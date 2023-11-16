class ChangeColumnDefaultToActivities < ActiveRecord::Migration[6.1]
  def change
    change_column_default :activities, :checked, from: nil, to: false
  end
end
