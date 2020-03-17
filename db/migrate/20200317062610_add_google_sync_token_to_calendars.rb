class AddGoogleSyncTokenToCalendars < ActiveRecord::Migration[6.0]
  def change
    add_column :calendars, :google_sync_token, :string
  end
end
