class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  belongs_to :category
  has_many :favorites, as: :favoritable
  has_many :kudos, as: :kudosible, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :actions, as: :actionable, dependent: :destroy
  validates :content, presence: true
  after_create :create_action
  default_scope -> { order('created_at DESC') }


  private

  def create_action
    Action.create(
      actionable: self,
      content: self.content,
      user: User.find(self.user_id)
    )
  end

end