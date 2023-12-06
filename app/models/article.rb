class Article < ApplicationRecord

  belongs_to :employee, ->{ includes(:department)}
  has_many :comments, ->{ includes(employee: :department)}, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags, source: :tag


  with_options presence: do
    validates :title, length: { maximum: 100 }
    validates :body
  end


  def favorited_by?(current_employee) = favorites.exists?(employee_id: current_employee.id)

  def created_by?(current_employee) = self.employee == current_employee

  def save_published
    self.is_published = true
    self.save
  end

  def save_private
    self.is_published = false
    self.save
  end

  def update_published(article_params)
    self.is_published = true
    self.update(article_params)
  end

  def update_private(article_params)
    self.is_published = false
    self.update(article_params)
  end

  def join_tags = self.tags.pluck(:name).join("、")

  def save_tags(send_tags) = send_tags.each{ |tag| self.tags << Tag.find_or_create_by(name: tag) }

  def update_tags(send_tags)
     # 編集前の投稿にタグが付いていれば、current_tagsに入れる
     current_tags = self.tags.pluck(:name) if self.tags
     old_tags = current_tags - send_tags
     new_tags = send_tags - current_tags
     old_tags.each{ |old_tag| self.tags.delete(Tag.find_by(name: old_tag)) }
     new_tags.each{ |new_tag| self.tags << Tag.find_or_create_by(name: new_tag) }
  end

  def self.search(keyword) = where("title LIKE ?", "%#{keyword}%")

  def self.is_published_articles = where(is_published: true).includes(:employee, :tags, :favorites, :comments)

end
