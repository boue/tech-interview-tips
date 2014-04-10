class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  belongs_to :category
  has_many :favorites, as: :favoritable
  has_many :kudos, as: :kudosible
end