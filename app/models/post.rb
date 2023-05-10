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
  #has_many :favorited_users, through: :favorites, source: :user
  #has_many :week_favorites, -> { where(created_at: ((Time.current.at_end_of_day - 6.day).at_beginning_of_day)..(Time.current.at_end_of_day)) }, class_name: 'Favorite'


  has_many :comments, dependent: :destroy

  #物足りないなどの量感のステータスをenumで管理
  enum volume_status: { full: 0, just_right: 1, not_enough: 2 }

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  def self.week_favorites
    where(created_at: ((Time.current.at_end_of_day - 6.day).at_beginning_of_day)..(Time.current.at_end_of_day))
  end

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_post_image.jpeg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  def favorited_by?(user)
    #後置修飾の"if user"は非ログイン時にいいねボタンを押すとログインページに遷移させたいため記述
    favorites.exists?(user_id: user.id) if user
  end

  def self.search_for(content, method)
    #if method == 'perfect'
    #  Post.where(menu: content)
    #elsif method == 'forward'
    #  Post.where('menu LIKE ?', content + '%')
    #elsif method == 'backward'
    #  Post.where('menu LIKE ?', '%' + content)
    #else
      Post.where('menu LIKE ?', '%' + content + '%')
   # end
  end

end
