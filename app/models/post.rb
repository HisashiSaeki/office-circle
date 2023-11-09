class Post < ApplicationRecord

  belongs_to :employee
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tag, source: :tag

end
