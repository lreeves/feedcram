class CreateViewed < ActiveRecord::Migration
  def change
    create_table :viewed do |t|
      t.integer :user_id
      t.integer :feed_id
      t.integer :feed_entry_id
    end

    add_index :viewed, [:user_id, :feed_id, :feed_entry_id], unique: true
  end
end
