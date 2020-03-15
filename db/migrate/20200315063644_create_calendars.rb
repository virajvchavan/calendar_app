class CreateCalendars < ActiveRecord::Migration[6.0]
  def change
    create_table :calendars do |t|
      t.string :g_id, null: false, unique: true
      t.string :summary
      t.string :timezone
      t.string :bg_color
      t.string :fg_color
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
