class User < ApplicationRecord
  before_save :downcase_email

  validates :name, presence: true,
             length: {maximum: Settings.user.name_user.max_length}
  validates :email, presence: true,
             length: {maximum: Settings.user.email.max_length},
             format: {with: Regexp.new(Settings.user.email.email_regex)},
             uniqueness: true

  has_secure_password

  # Returns the hash digest of the given string.
  def self.digest string
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create string, cost:
  end

  private

  def downcase_email
    email.downcase!
  end
end
