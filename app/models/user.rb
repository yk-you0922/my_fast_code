class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i(google)

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :contacts
  has_many :favorites, dependent: :destroy
  has_many :favorites_posts, through: :favorites, source: :post
  has_many :comment_favorites, dependent: :destroy
  has_many :favorited_comments, through: :comment_favorites, source: :comment

  attachment :image

  # バリデーション
  validates :name, presence: true, length: {maximum: 20}
  validates :introduction, length: {maximum: 200}


  # 自分がフォローしているユーザーとの関連
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower

  # 自分がフォローされているユーザーとの関連
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following

  def followed_by?(user)
    # 今自分（引数のuser)がフォローしようとしているユーザー（レシーバー）がフォローされているユーザーの中から自分がいるかどうかを調べる
    passive_relationships.find_by(following_id: user.id).present?
  end

  protected
  
  def self.find_for_google(auth)
    user = User.find_by(email: auth.info.email)

    unless user
      user = User.create(email: auth.info.email,
                         name:     auth.info.name,
                         provider: auth.provider,
                         uid:      auth.uid,
                         token:    auth.credentials.token,
                         password: Devise.friendly_token[0, 20],
                         meta:     auth.to_yaml
                        )
    end
    user
  end

  
end
