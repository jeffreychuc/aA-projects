class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :url
      t.string :content
      t.string :sub_id, null: false
      t.string :author_id, null: false
      t.timestamps
    end
  end
end
