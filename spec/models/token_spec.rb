# == Schema Information
#
# Table name: tokens
#
#  id            :bigint           not null, primary key
#  user_id       :integer
#  access_token  :string
#  refresh_token :string
#  expires_at    :integer
#  provider      :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require 'rails_helper'

RSpec.describe Token, type: :model do
  describe '#user_id' do
    it { should validate_presence_of(:user_id) }
  end

  describe '#provider' do
    it { should validate_presence_of(:provider) }
    it { should validate_inclusion_of(:provider).in_array(['google']) }
  end
end
