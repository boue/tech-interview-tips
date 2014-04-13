class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  belongs_to :category
  has_many :favorites, as: :favoritable
  has_many :kudos, as: :kudosible
  has_many :comments, as: :commentable, dependent: :destroy

  validates :content, presence: true

  after_create :create_activity

  private

  def create_activity
    Action.create(
      actionable: self,
      content: 'New answer:',
      user: User.find(self.user_id)
    )
  end

end