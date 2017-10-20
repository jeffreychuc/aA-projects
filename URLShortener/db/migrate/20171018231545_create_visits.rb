class CreateVisits < ActiveRecord::Migration[5.1]
  def change
    create_table :visits do |t|
      t.integer :num_visits, null: false
      t.integer :short_url_id, unique: true
      t.timestamps
    end

    add_index :visits, :short_url_id
  end
end
