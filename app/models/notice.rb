class Notice < ApplicationRecord
  
  belongs_to :group
  
  
  with_options presence: do
    validates :title, length: { maximum: 100 }
    validates :body
  end
  
  
end
