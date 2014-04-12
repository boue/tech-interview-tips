class User < ActiveRecord::Base
  has_many :questions
  has_many :answers
  has_many :comments
  has_many :favorites
  has_many :kudos

  def self.from_omniauth(auth)
    where(auth.slice("provider", "uid")).first || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["nickname"]
      # user.email = auth["email"]
    end
  end
end