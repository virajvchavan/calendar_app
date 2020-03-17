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
  has_many :calendars, dependent: :destroy
  has_many :events, through: :calendars

  def self.from_omniauth(auth)
    user = where(email: auth.info.email).first_or_initialize do |record|
      record.name = auth.info.name
      record.email = auth.info.email
      record.picture_url = auth.info.image
    end
    fetch_user_data = user.new_record? ? true : false
    user.save
    [user, fetch_user_data]
  end

  def google_token
    tokens.find_by(provider: 'google')
  end

  # TODO: Move these methods to a better place, maybe into a job
  def load_calendars_with_events(page_token = nil)
    service = GoogleCalendarApi.new(google_token)
    response = service.calendar_list({
      pageToken: page_token,
      syncToken: self.google_sync_token
    })
    response[:items].each do |item|
      c = calendars.find_or_create_by(g_id: item[:g_id])
      c.assign_attributes(item.except(:g_id))
      c.save!
      load_events(c, service)
    end
    if response[:nextPageToken]
      load_calendars_with_events(service, response[:nextPageToken])
    end
    if response[:nextSyncToken]
      self.update(google_sync_token: response[:nextSyncToken])
    end
  end

  def load_events(calendar, service, page_token = nil)
    response = service.calendar_events(calendar.g_id, {
      pageToken: page_token,
      syncToken: calendar.google_sync_token
    })
    response[:items].each do |item|
      event = calendar.events.find_or_create_by(g_id: item[:g_id])
      event.assign_attributes(item.except(:g_id))
      event.save!
    end
    if response[:nextPageToken]
      load_events(calendar, service, response[:nextPageToken])
    end
    if response[:nextSyncToken]
      calendar.update(google_sync_token: response[:nextSyncToken])
    end
  end
end
