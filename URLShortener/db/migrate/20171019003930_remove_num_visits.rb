class RemoveNumVisits < ActiveRecord::Migration[5.1]
  def change
    remove_column :visits, :num_visits
  end
end
