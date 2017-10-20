class AddUserIdToVisits < ActiveRecord::Migration[5.1]
  def change
    add_column :visits, :user_id, :integer, null: false
    change_column :visits, :num_visits, :integer, default: 0, null: false
  end
end
