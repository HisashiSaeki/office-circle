class Favorite < ApplicationRecord

  belongs_to :employee
  belongs_to :article
  
  validates :employee_id, uniqueness: {scope: :article_id}
  
end
