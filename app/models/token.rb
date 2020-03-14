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
class Token < ApplicationRecord
  belongs_to :user

  def expired?
    expires_at <= Time.now.to_i
  end

  def refresh_token!
    if provider == 'google'
      response = HTTParty.post('https://oauth2.googleapis.com/token', :body => {
        :grant_type => 'refresh_token',
        :refresh_token => self.refresh_token,
        :client_id => '442426075807-gilanod1mo02kuq9fmeefpgghdmh9ure.apps.googleusercontent.com',
        :client_secret => 'QmrU8p_GW79NSCWte_isTmTB'},
      )

      # todo: handle api failure here
      new_access_token = JSON.parse(response.body)
      self.access_token = new_access_token['access_token']
      self.expires_at = Time.now.to_i + new_access_token['expires_in'].to_i
      self.save
      self
    end
  end
end
