class AddSlugToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :slug, :string
    # slug is a friendly_id feature
  end
end
