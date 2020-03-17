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
  pending "add some examples to (or delete) #{__FILE__}"
end
