class Answer < ActiveRecord::Base
  include CreateAction
  belongs_to :question
  belongs_to :user
  belongs_to :category
  has_many :favorites, as: :favoritable
  has_many :kudos, as: :kudosible, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :actions, as: :actionable, dependent: :destroy
  validates :content, presence: true
  after_create :create_action_with_content
  default_scope -> { order('created_at DESC') }
end