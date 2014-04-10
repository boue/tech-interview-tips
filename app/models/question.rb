class Question < ActiveRecord::Base
  has_many :answers
  belongs_to :user
  has_many :favorites, as: :favoritable
end