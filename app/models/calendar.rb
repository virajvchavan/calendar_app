# == Schema Information
#
# Table name: calendars
#
#  id                :bigint           not null, primary key
#  g_id              :string           not null
#  summary           :string
#  timezone          :string
#  bg_color          :string
#  fg_color          :string
#  user_id           :bigint           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  google_sync_token :string
#
class Calendar < ApplicationRecord
  belongs_to :user
  has_many :events, dependent: :destroy

  def daily_events
    events.active.where(
      start_time: DateTime.now.beginning_of_day.utc..DateTime.now.end_of_day.utc
    ).as_json
  end

  def active_events
    events.where('status != ?', 'cancelled')
  end
end
