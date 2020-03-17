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
  context 'validations' do
    it { should validate_presence_of(:g_id) }
    it { should validate_presence_of(:calendar_id) }
  end

  context 'associations' do
    it { should belong_to(:calendar) }
  end
end
