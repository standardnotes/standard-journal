class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :uuid
      t.string :title
      t.text :content
      t.string :path
      t.boolean :published, :default => true
      t.timestamps
    end
  end
end
