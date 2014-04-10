class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :content
      t.integer :question_id
      t.integer :category_id
      t.integer :user_id
      t.timestamps
    end
  end
end
