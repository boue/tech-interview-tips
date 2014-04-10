class Comment < ActiveRecord::Base
  # basic self join lines 3-5 below
  has_many :comment_child, class_name: "Comment",
                          foreign_key: "comment_parent_id"
  belongs_to :comment_parent, class_name: "Comment"

  # below makes polymorphic association
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable
end