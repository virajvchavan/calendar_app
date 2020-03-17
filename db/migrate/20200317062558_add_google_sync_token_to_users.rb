class AddGoogleSyncTokenToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :google_sync_token, :string
  end
end
