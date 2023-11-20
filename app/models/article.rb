class Article < ApplicationRecord

  belongs_to :employee
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags, source: :tag


  with_options presence: do
    validates :title, length: { maximum: 100 }
    validates :body
  end


  def favorited_by?(employee) = self.favorites.exists?(employee_id: employee.id)

  def save_tags(send_tags) = send_tags.each { |tag| self.tags << Tag.find_or_create_by(name: tag) }

  def update_tags(send_tags)
     # 編集前の投稿にタグが付いていれば、current_tagsに入れる
     current_tags = self.tags.pluck(:name) unless !self.tags
     old_tags = current_tags - send_tags
     new_tags = send_tags - current_tags
     old_tags.each { |old_tag| self.tags.delete(Tag.find_by(name: old_tag)) }
     new_tags.each { |new_tag| self.tags << Tag.find_or_create_by(name: new_tag) }
  end

  def self.search(keyword) = self.where("title LIKE ?", "%#{keyword}%")

end
