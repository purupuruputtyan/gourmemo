class Post < ApplicationRecord

  validates :shop_name, presence: true, length: { maximum: 30 }
  validates :menu, presence: true, length: { maximum: 30 }
  validates :impression, length: { maximum: 100 }
  validates :volume_status, presence: true
  validates :star, presence: true

  has_one_attached :image

  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :post

  #物足りないなどの量感のステータスをenumで管理
  enum volume_status: { full: 0, just_right: 1, not_enough: 2 }

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_post_image.jpeg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

end
