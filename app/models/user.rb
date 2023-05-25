class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable

  validates :name, presence: true, uniqueness: true, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }
  validates :status, presence: true

  has_one_attached :profile_image

  #ユーザーに在籍状況ステータスを設け、”公開”、”非公開”、”退会のユーザー”をenumでまとめて管理
  enum status: { released: 0, nonreleased: 1, withdraw: 2 }

  #在籍状況ステータスが”退会”以外のユーザーをユーザー一覧で表示させるためのscope
  scope :active_user, -> { where(status: 0).or(where(status: 1)).order(created_at: :desc) }

  has_many :posts, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :post

  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower

  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed

  has_many :comments, dependent: :destroy

  #ユーザーがプロフィール写真を設定できるようにするため
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpeg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant({gravity: :center, resize: "#{width}x#{height}^", crop: "#{width}x#{height}+0+0"}).processed
  end

  #理論退会機能用。在籍状況ステータスが"withdraw?"(退会)だったら強制ログアウトさせる
  def active_for_authentication?
    super && !self.withdraw?
  end

  #ゲストログイン機能用
  def self.guest
    #find_or_create_by!→データの検索と作成を自動的に判断して処理を行うRailsのメソッド
    find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com') do |user|
      #SecureRandom.urlsafe_base64→ランダムな文字列を生成するRubyのメソッドの一種
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end

  #フォロー機能、フォローする時の処理
  def follow(user)
    relationships.find_or_create_by(followed_id: user.id)
  end

  #フォロー機能、フォローを外す時の処理
  def unfollow(user)
    relationships.find_by(followed_id: user.id).destroy
  end

  #すでにフォローしているのか確認
  def following?(user)
    followings.include?(user)
  end

  #ユーザー名を曖昧検索をするため
  def self.search_for(content)
    if content != nil
      User.where('name LIKE ?', '%' + content + '%')
    else
      User.all
    end
  end

end