class Kudo < ActiveRecord::Base
  belongs_to :kudosible, polymorphic: true
  belongs_to :user
  has_many :actions, as: :actionable, dependent: :destroy
  after_create :create_action

  def self.assign(data, user, kudo)
    unless data.kudos.find_by(user_id: user.id)
      kudo.user_id = user.id
      data.kudos << kudo
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