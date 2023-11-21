class Favorite < ApplicationRecord

  belongs_to :employee
  belongs_to :article
  
  
  has_one :activity, as: :subject, dependent: :destroy
  after_create_commit :create_activities
  
  
  validates :employee_id, uniqueness: {scope: :article_id}
  
  
  private
  
  
  def create_activities = Activity.create(subject: self, employee: self.article.employee, action_type: :liked_to_own_article)
  
  
end
