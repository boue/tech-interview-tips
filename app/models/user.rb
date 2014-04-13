class User < ActiveRecord::Base
  has_many :questions
  has_many :answers
  has_many :comments
  has_many :favorites
  has_many :kudos
  has_many :actions

  def self.from_omniauth(auth)
    where(auth.slice("provider", "uid")).first || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["nickname"]
      # require "pry"; binding.pry
      user.email = auth["info"]["email"]
      user.url = auth["info"]["urls"]["public_profile"]
    end
  end
end