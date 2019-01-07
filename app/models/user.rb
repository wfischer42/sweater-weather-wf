class User < ApplicationRecord
  has_secure_password
  validates_presence_of :email, :password
  before_save :generate_token

  private
  def generate_token
    self.token = SecureRandom.uuid.tr('-', '')
  end
end
