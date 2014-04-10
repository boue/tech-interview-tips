class Question < ActiveRecord::Base
  has_many :answers
  belongs_to :user
  has_many :favorites, as: :favoritable

  validates :title, presence: true
  validates :content, presence: true
end