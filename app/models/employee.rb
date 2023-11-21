class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  
  belongs_to :department
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :group_members, dependent: :destroy
  has_many :groups, through: :group_members, source: :group
  has_many :favorite_articles, through: :favorites, source: :article
  has_many :activities, dependent: :destroy
  
  
  has_one_attached :profile_image
  
  
  with_options presence: do
    validates :last_name
    validates :first_name
    validates :last_name_furigana
    validates :last_name_furigana
    validates :department_id
    validates :birthdate
    validates :prefecture
    validates :email
  end
  
  
  def get_profile_image(width,height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
  
  def full_name = self.last_name + " " + self.first_name
    
  def full_name_furigana = self.last_name_furigana + " " + self.first_name_furigana
    
  def self.search(keyword)
    self.where(
      "first_name LIKE ? or last_name LIKE ? or first_name_furigana LIKE ? or last_name_furigana LIKE ?", 
      "%#{keyword}%","%#{keyword}%", "%#{keyword}%", "%#{keyword}%"
    )
  end
  
  GUEST_USER_EMAIL = "guest@example.com"
  
  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL ) do |employee|
      employee.password = SecureRandom.urlsafe_base64
      employee.last_name = "ゲスト"
      employee.first_name = "ユーザー"
      employee.last_name_furigana = "ゲスト"
      employee.first_name_furigana = "ユーザー"
      employee.department = Department.find_by(id: 1)
      employee.birthdate = "1999-11-11"
      employee.prefecture = "東京都"
    end
  end
  
  def guest_employee?
    email == GUEST_USER_EMAIL
  end
  
end
