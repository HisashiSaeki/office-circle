class Comment < ApplicationRecord
  
  belongs_to :employee, ->{ includes(:department)}
  belongs_to :article
  
  
  has_one :activity, as: :subject, dependent: :destroy
  after_create_commit :create_activities
  
  
  validates :comment, presence: true
  
    
  private
  
  
  def create_activities = Activity.create(subject: self, employee: article.employee, action_type: :commented_to_own_article)
    
    
end
