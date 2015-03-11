class User < ActiveRecord::Base

  before_save { email.downcase! }
  before_create :create_remember_token

  validates :name,  presence: true, length: { maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_secure_password

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      begin
        self.remember_token = User.digest(User.new_remember_token)
      end while self.class.exists?(remember_token: remember_token)
    end
end
