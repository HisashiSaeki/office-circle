class Post < ApplicationRecord

  belongs_to :employee
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_tag, dependent: :destroy

  def self.my_favorite_post(employee)
    if employee.favorites.exists?
      favorites = Favorite.where(employee_id: employee).select(:post_id)
      Post.where(favorites)
    end
  end

end
