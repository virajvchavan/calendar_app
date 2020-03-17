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
  context 'validations' do
    it { should validate_presence_of(:g_id) }
    it { should validate_presence_of(:user_id) }
  end

  context 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:events) }
  end
end
