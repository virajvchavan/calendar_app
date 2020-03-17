class AddIndexesToEvents < ActiveRecord::Migration[6.0]
  def change
    add_index :events, [:calendar_id, :g_id], unique: true
    add_index :events, :start_time
    add_index :events, :end_time
  end
end
