class Kudo < ActiveRecord::Base
  belongs_to :kudosible, polymorphic: true
  belongs_to :user
  after_create :create_action

  private

  def create_action
    Action.create(
      actionable: self,
      content: 'thumbs up',
      user: User.find(self.user_id)
    )
  end
end