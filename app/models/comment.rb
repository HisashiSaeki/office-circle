class Comment < ApplicationRecord
  
  belongs_to :employee
  belongs_to :article
  
  validates :comment, presence: true
  
  def create_date = created_at.strftime("%Y-%m-%d")
end
