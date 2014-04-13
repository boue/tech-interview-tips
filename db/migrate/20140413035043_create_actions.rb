class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.references :actionable, polymorphic: true
      t.string :content
      t.integer :user_id
      t.timestamps
    end

    add_index :actions, :actionable_id
    add_index :actions, :actionable_type
    add_index :actions, :user_id
  end
end