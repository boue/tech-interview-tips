class CreateKudos < ActiveRecord::Migration
  def change
    create_table :kudos do |t|
      t.integer :user_id
      t.references :kudosible, polymorphic: true
      t.timestamps
    end
  end
end
