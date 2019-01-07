class User < ApplicationRecord
  has_secure_password
  has_many :user_locations
  has_many :favorites,
           through: :user_locations

  validates_presence_of :email, :password
  before_save :generate_token

  def self.find_and_authenticate_by(params)
    if user = find_by(email: params[:email])
      user.authenticate(params[:password])
    end
  end

  def add_favorite(location)
    self.favorites << location
  end

  private
  def generate_token
    self.token = SecureRandom.uuid.tr('-', '')
  end
end
