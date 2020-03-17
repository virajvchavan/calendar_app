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

  validates :user_id, presence: true
  validates :provider, presence: true, inclusion: { in: ['google']}

  def expired?
    expires_at <= Time.now.to_i
  end

  def refresh_token!
    return unless provider == 'google'

    response = fetch_google_access_token
    # todo: handle api failure here
    puts 'refresh token response: ' + response.to_s

    new_access_token = JSON.parse(response.body)
    if (new_access_token['access_token'])
      self.access_token = new_access_token['access_token']
      self.expires_at = Time.now.to_i + new_access_token['expires_in'].to_i
      self.save
    end
    self
  end

  private
  def fetch_google_access_token
    HTTParty.post('https://oauth2.googleapis.com/token', body: {
        grant_type: 'refresh_token',
        refresh_token: self.refresh_token,
        client_id: ENV['google_client_id'],
        client_secret: ENV['google_client_secret']
      }
    )
  end
end
