module CreateAction
  def create_action
    Action.create(
      actionable: self,
      content: self.title,
      user: User.find(self.user_id)
    )
  end
end
