class ChangeContentFormatInActions < ActiveRecord::Migration
  def change
    change_column :actions, :content, :text
  end
end
