class User < ApplicationRecord
  has_many :microposts, dependent: :destroy
  has_many :active_likes, class_name:  "Like",
                          foreign_key: "liker_id",
                          dependent:   :destroy
  
  has_many :liking, through: :active_likes, source: :liked

  attr_accessor :remember_token, :activation_token
  before_save   :downcase_email
  before_create :create_activation_digest
  VALID_userid_REGEX = /\A[a-z\d\-.]+\z/i
  validates :user_id, presence: true, length: { maximum: 50 }, uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence:   true, length: { maximum: 255 },
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validates :profile, presence: true, length: { maximum: 150 },allow_blank: true
  validates :name, presence: true, length: { maximum: 30 },allow_blank: true
  mount_uploader :picture, PictureUploader
  validate  :picture_size

  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # 永続セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # トークンがダイジェストと一致したらtrueを返す
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end

  # アカウントを有効にする
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # 有効化用のメールを送信する
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def feed
    following_ids = "SELECT user_id FROM microposts"
    Micropost.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end

  def myfeed
    Micropost.where("user_id = ?", id)
  end

  def userfeed
    following_ids = "SELECT user_id FROM microposts"
    Micropost.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end

  # マイクロポストをライクする
  def like(other_user)
    active_likes.create(liker_id: other_user.id)
  end

  # マイクロポストのライクを解除する
  def unlike(other_user)
    active_likes.find_by(liker_id: other_user.id).destroy
  end

  # 現在のユーザーがライクしてたらtrueを返す
  def liking?(other_user)
    liking.include?(other_user)
  end

  private


    # メールアドレスをすべて小文字にする
    def downcase_email
      self.email = email.downcase
    end

    # 有効化トークンとダイジェストを作成および代入する
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end

    # アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end