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
  pending "add some examples to (or delete) #{__FILE__}"
end
