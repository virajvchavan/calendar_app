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
require 'rails_helper'

RSpec.describe Event, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
