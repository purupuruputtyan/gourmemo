class Post < ApplicationRecord
  
  validates :name, presence: true, uniqueness: true, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }
  validates :status, presence: true
  
  has_one_attached :post_image
  
  belongs_to :user
  
  has_many :favorites, dependent: :destroy
  
  #物足りないなどの量感のステータスをenumで管理
  enum volume_status: { full: 0, just_right: 1, not_enough: 2 }
  
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  
  def get_post_image(width, height)
    unless post_image.attached?
      file_path = Rails.root.join('app/assets/images/no_post_image.jpeg')
      post_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    post_image.variant(resize_to_limit: [width, height]).processed
  end
  
end
