class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  validates :username, presence: :true, uniqueness: :true
  validates :email, presence: :true, uniqueness: :true

  def slug
    self.username.gsub(' ', '-')
  end

  def self.find_by_slug(slug)
    User.find_by(username: slug.gsub('-', ' '))
  end
end
