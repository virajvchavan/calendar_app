# == Schema Information
#
# Table name: users
#
#  id                :bigint           not null, primary key
#  name              :string
#  email             :string
#  picture_url       :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  google_sync_token :string
#
require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
  end

  context 'associations' do
    it { should have_many(:calendars) }
    it { should have_many(:tokens) }
  end
end
