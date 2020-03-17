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
  describe '#email' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
  end
end
