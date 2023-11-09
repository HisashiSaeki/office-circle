class Comment < ApplicationRecord
  
  belongs_to :employee
  belongs_to :article
  
  def create_date = self.created_at.strftime("%Y-%m-%d")
end
