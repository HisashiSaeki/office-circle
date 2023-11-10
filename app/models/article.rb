class Article < ApplicationRecord

  belongs_to :employee
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags, source: :tag
  
  def create_date = self.created_at.strftime("%Y-%m-%d")
  def update_date = self.updated_at.strftime("%Y-%m-%d")
  
  def favorited_by?(employee) = self.favorites.exists?(employee_id: employee.id)
  
  def save_tags(send_tags)
    send_tags.each do |tag|
      new_tag = Tag.find_or_create_by(name: tag)
      self.tags << new_tag
    end
  end
  
  def update_tags(send_tags)
    current_tags = self.tags.pluck(:name) unless !self.tags
    old_tags = current_tags - send_tags
    new_tags = send_tags - current_tags
    
    old_tags.each do |old_tag|
      self.tags.delete(Tag.find_by(name: old_tag))
    end
    
    new_tags.each do |tag|
      new_tag = Tag.find_or_create_by!(name: tag)
      self.tags << new_tag
    end
    
  end

end
