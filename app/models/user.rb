class User < ApplicationRecord
  before_save :downcase_email

  validates :name, presence: true,
             length: {maximum: Settings.user.name_user.max_length}
  validates :email, presence: true,
             length: {maximum: Settings.user.email.max_length},
             format: {with: Regexp.new(Settings.user.email.email_regex)},
             uniqueness: true

  has_secure_password

  private

  def downcase_email
    email.downcase!
  end
end
