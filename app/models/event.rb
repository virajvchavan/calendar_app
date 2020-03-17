# == Schema Information
#
# Table name: events
#
#  id            :bigint           not null, primary key
#  g_id          :string           not null
#  summary       :string
#  description   :text
#  location      :string
#  status        :string
#  html_link     :string
#  start_time    :datetime
#  end_time      :datetime
#  all_day_event :boolean
#  calendar_id   :bigint           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Event < ApplicationRecord
  belongs_to :calendar

  validates :g_id, uniqueness: { scope: :calendar_id }, presence: true
  validates :calendar_id, presence: true

  scope :active,  -> { where('status != ?', 'cancelled') }
end
