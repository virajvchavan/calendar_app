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
require 'rails_helper'

RSpec.describe Calendar, type: :model do
  describe '#g_id' do
    it { should validate_presence_of(:g_id) }
  end

  describe '#user_id' do
    it { should validate_presence_of(:user_id) }
  end
end
