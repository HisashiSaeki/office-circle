class Article < ApplicationRecord

  belongs_to :employee
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags, source: :tag
  
  def create_date = self.created_at.strftime("%Y-%m-%d")
  def update_date = self.updated_at.strftime("%Y-%m-%d")

end
