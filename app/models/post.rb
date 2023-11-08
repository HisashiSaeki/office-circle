class Post < ApplicationRecord
  
  belongs_to :employee
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_tag, dependent: :destroy
end
