class Article < ApplicationRecord

  belongs_to :employee
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags, source: :tag
  
  def create_date = created_at.strftime("%Y-%m-%d")
  def update_date = updated_at.strftime("%Y-%m-%d")
  
  def favorited_by?(employee) = favorites.exists?(employee_id: employee.id)

end
