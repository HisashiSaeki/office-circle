class Department < ApplicationRecord

  has_many :employees, ->{ order(created_at: :desc) }


  validates :name, presence: true, uniqueness: true

end
