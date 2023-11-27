class Activity < ApplicationRecord
  
  belongs_to :subject, polymorphic: true
  belongs_to :employee
  
  
  enum action_type: {commented_to_own_article: 1, liked_to_own_article: 2, noticed_to_participating_group: 3}
  
end
