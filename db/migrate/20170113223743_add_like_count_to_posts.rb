class AddLikeCountToPosts < ActiveRecord::Migration[5.0]
  def change
    change_table(:posts) do |t|
      t.integer :like_count, :default => 0
    end
  end
end
