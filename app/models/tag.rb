class Tag < ApplicationRecord
  has_many :article_tags
  has_many :articles, -> { where(is_published: true).includes(:tags, :favorites, :comments, employee: :department).order(created_at: :desc) }, through: :article_tags, source: :article

  validates :name, presence: true, uniqueness: true

  def self.published_article_tags
    published_articles = Article.where(is_published: true)
    tag_list = ArticleTag.where(article_id: published_articles).pluck(:tag_id)
    self.where(id: tag_list)
  end
end
