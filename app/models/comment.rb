class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable
  validates :content, presence: true
  belongs_to :user
  after_create :create_action
  default_scope -> { order('created_at DESC') }

  private

  def create_action
    Action.create(
      actionable: self,
      content: 'New comment:',
      user: User.find(self.user_id)
    )
  end

end