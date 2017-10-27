class CreateFeeds < ActiveRecord::Migration[5.0]
  def change
    create_table :feeds do |t|
      t.string :url
      t.string :title
      t.timestamps
    end

    add_index :feeds, :url, unique: true
  end
end
