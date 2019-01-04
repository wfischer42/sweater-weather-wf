class User < ApplicationRecord
  has_secure_password
  validates_presence_of :email, :password
  before_save :generate_api_key

  def api_key
    new_key ? new_key : "Key is no longer valid."
  end

  def valid_key?(api_key)
    valid_key = BCrypt::Password.new(api_key_digest)
    valid_key == api_key
  end

  private
  attr_reader :new_key

  def generate_api_key
    @new_key = SecureRandom.uuid.tr('-', '')
    self.api_key_digest = BCrypt::Password.create(new_key)
  end
end
