class Post < ApplicationRecord

  validates :shop_name, presence: true, length: { maximum: 30 }
  validates :menu, presence: true, length: { maximum: 30 }
  validates :impression, presence: true, length: { maximum: 100 }
  validates :volume_status, presence: true
  validates :star, presence: true

  has_one_attached :image

  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :post

  has_many :comments, dependent: :destroy

  #物足りないなどの量感のステータスをenumで管理
  enum volume_status: { full: 0, just_right: 1, not_enough: 2 }

  #投稿詳細画面でお店の住所の地図を表示させるため
  #ユーザーに入力してもらった住所から緯度経度をgeocorderで取得
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  #トップページを過去１週間のいいね順で投稿一覧を表示させるため
  def self.week_posts
    where(created_at: ((Time.current.at_end_of_day - 6.day).at_beginning_of_day)..(Time.current.at_end_of_day))
  end

  #投稿機能に画像も投稿できるようにするため
  def get_image(width, height, shape = "rectangle")
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_post_image.jpeg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    #投稿履歴のみ正方形で表示するため
    if shape == "square"
      image.variant({gravity: :center, resize: "#{width}x#{height}^", crop: "#{width}x#{height}+0+0"}).processed
    else
      image.variant(resize_to_limit: [width, height]).processed
    end
  end

  #引数で渡されたユーザidがFavoritesテーブル内に存在するか確認する
  def favorited_by?(user)
    #後置修飾の"if user"は記述しないと非ログイン時にいいね機能のある画面を表示できないため記述
    favorites.exists?(user_id: user.id) if user
  end

  #メニュー名を曖昧検索するためのメソッド
  def self.search_for(content)
    if content != nil
      Post.where('menu LIKE ?', '%' + content + '%')
    else
      Post.all
    end
  end

end
