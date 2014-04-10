class Question < ActiveRecord::Base
  has_many :answers
  has_many :favorites, as: :favoritable
  has_many :comments, as: :commentable
  belongs_to :user
end