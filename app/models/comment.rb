class Comment < ActiveRecord::Base
  include CreateAction
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable
  has_many :actions, as: :actionable, dependent: :destroy
  validates :content, presence: true
  belongs_to :user
  after_create :create_action_with_content
  default_scope -> { order('created_at DESC') }
end