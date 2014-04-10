class Kudo < ActiveRecord::Base
  belongs_to :kudosible, polymorphic: true
  belongs_to :user

end
