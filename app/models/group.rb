class Group < ApplicationRecord
  
  has_many :group_members, dependent: :destroy
  has_many :notices, dependent: :destroy
  belongs_to :creater, class_name: "Employee"
  has_many :employees, through: :group_members
end