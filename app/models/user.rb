class User < ApplicationRecord
  attr_accessor :remember_token
  before_save :downcase_email

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255},
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false } # rails infers that uniqueness should be true as well
  has_secure_password
  # When editing user info, allow the password fields to be blank (allow_nil).
  # For new users, the above "has_secure_password" statement will still check for presence.
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  has_many :posts

  # Returns the hash digest of the given string.
  def User.digest(string)
    # Cost is the computational cost to calculate the hash. Using a high cost
    # makes it computationally intractable to use the hash to determine the
    # original password, which is an important security precaution in a
    # production environment, but in tests we want the digest method to be as
    # fast as possible.
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")  # access the specified User attribute
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  private

    # Converts email to all lower-case.
    def downcase_email
      email.downcase!
    end
end
