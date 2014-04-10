class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.text :content
      t.integer :user_id
      t.integer :views
      # views is the number of times the question show page has been viewed
      t.timestamps
    end
  end
end
