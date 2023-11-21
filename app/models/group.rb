class Group < ApplicationRecord
  
  has_many :notices, dependent: :destroy
  has_many :group_members, dependent: :destroy
  has_many :employees, through: :group_members, source: :employee
  belongs_to :creater, class_name: "Employee"
  
  with_options presence: do
    validates :name
    validates :description
    validates :creater_id
  end
  
  # グループ画像の挿入は検討中
  # has_one_attached :group_image
  
  
  # def get_group_image(width,height)
  #   unless group_image.attached?
  #     file_path = Rails.root.join('app/assets/images/no_image.jpg')
  #     group_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  #   end
  #   group_image.variant(resize_to_limit: [width, height]).processed
  # end
  
  def is_created_by?(employee) = self.creater_id == employee.id
    
  def self.search(keyword) = self.where("name LIKE ? or description LIKE ?", "%#{keyword}%", "%#{keyword}%")
  
end

