class Notice < ApplicationRecord
  
  belongs_to :group
  
  
  with_options presence: do
    validates :title
    validates :body
  end
end
