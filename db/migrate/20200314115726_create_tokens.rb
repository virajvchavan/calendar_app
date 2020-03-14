class CreateTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :tokens do |t|
      t.integer :user_id
      t.string :access_token
      t.string :refresh_token
      t.integer :expires_at
      t.string :provider

      t.timestamps
    end
  end
end
