# == Schema Information
#
# Table name: users
#
#  id          :bigint           not null, primary key
#  name        :string
#  email       :string
#  picture_url :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class User < ApplicationRecord
  has_many :tokens, dependent: :destroy

  def self.from_omniauth(auth)
    user = where(email: auth.info.email).first_or_initialize do |record|
      record.name = auth.info.name
      record.email = auth.info.email
      record.picture_url = auth.info.image
    end
    user.new_record? && user.save
    user
  end

  def google_token
    tokens.find_by(provider: 'google')
  end
end
