class Category < ActiveRecord::Base
  has_many :answers

  validates :content, uniqueness: true
end