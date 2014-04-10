class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string  :content
      # below is for self-join
      # t.references :comment_parent
      # below is for polymorphic association
      t.references :commentable, polymorphic: true
      t.timestamps
    end
  end
end
