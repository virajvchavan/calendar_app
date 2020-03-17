class AddIndexesToCalendars < ActiveRecord::Migration[6.0]
  def change
    add_index :calendars, [:user_id, :g_id], unique: true
  end
end
