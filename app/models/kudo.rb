class Kudo < ActiveRecord::Base
  belongs_to :kudosible, polymorphic: true
  belongs_to :user
  has_many :actions, as: :actionable, dependent: :destroy
  after_create :create_action

  def self.assign(kudosible_object, user, kudo)
    unless kudosible_object.kudos.find_by(user_id: user.id)
      kudo.user_id = user.id
      kudosible_object.kudos << kudo
      kudo.save
    end
  end

  private

  def create_action
    Action.create(
      actionable: self,
      content: '',
      user: User.find(self.user_id)
    )
  end

end