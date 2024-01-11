class Group < ApplicationRecord

  has_many :group_members, dependent: :destroy
  has_many :employees, -> { includes(:department).order(created_at: :desc) }, through: :group_members, source: :employee
  belongs_to :creater, -> { includes(:department) }, class_name: "Employee"
  has_many :notices, -> { order(created_at: :desc) }, dependent: :destroy


  after_create_commit :create_group_members


  with_options presence: do
    validates :name, length: { maximum: 100 }
    validates :description
    validates :creater_id
  end


  def create_group_members = GroupMember.create(employee_id: self.creater_id, group_id: self.id)

  def created_by?(employee)
    creater_id == employee.id
  end

  def self.search(keyword) = self.where("name LIKE ? or description LIKE ?", "%#{keyword}%", "%#{keyword}%")


end
