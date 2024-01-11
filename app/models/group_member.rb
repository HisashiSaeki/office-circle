class GroupMember < ApplicationRecord

  belongs_to :employee
  belongs_to :group

  validates :employee_id, uniqueness: { scope: :group_id }

end
