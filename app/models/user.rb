class User < ActiveRecord::Base
  has_many :stats
  has_many :reservoirs, through: :stats

  validates_presence_of :username
  validates_uniqueness_of :username
  validates_presence_of :password
  validates_presence_of :email
  validates_uniqueness_of :email

  def password
    @password ||= BCrypt::Password.new(password_hash)
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.password_hash = @password
  end

  def authenticate?(email, txt_password)
    self.email == email && self.password == txt_password
  end

end
