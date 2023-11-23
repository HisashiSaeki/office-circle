class Group < ApplicationRecord

  has_many :notices, dependent: :destroy
  has_many :group_members, dependent: :destroy
  has_many :employees, through: :group_members, source: :employee
  belongs_to :creater, class_name: "Employee"

  with_options presence: do
    validates :name, length: { maximum: 100 }
    validates :description
    validates :creater_id
  end

  def is_created_by?(employee)
    self.creater_id == employee.id
  end

  def self.search(keyword) = self.where("name LIKE ? or description LIKE ?", "%#{keyword}%", "%#{keyword}%")

end

