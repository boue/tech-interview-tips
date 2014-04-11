class AddSlugIndexToQuestions < ActiveRecord::Migration
  def change
    add_index :questions, :slug, unique: true
  end
end