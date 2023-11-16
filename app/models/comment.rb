class Comment < ApplicationRecord
  
  belongs_to :employee
  belongs_to :article
  
  validates :comment, presence: true
  
  def create_date = created_at.strftime("%Y-%m-%d")
    
    
  private
  
  
  def create_activities = Activity.create(subject: self, employee: article.employee, action_type: :commented_to_own_article)
    
    
end
