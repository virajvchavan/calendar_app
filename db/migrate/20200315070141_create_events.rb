class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :g_id, null: false, unique: true
      t.string :summary
      t.text :description
      t.string :location
      t.string :status
      t.string :html_link
      t.datetime :start_time
      t.datetime :end_time
      t.boolean :all_day_event
      t.references :calendar, null: false, foreign_key: true

      t.timestamps
    end
  end
end
