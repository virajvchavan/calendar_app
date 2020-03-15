class GoogleCalendarApi
  include HTTParty
  base_uri 'https://www.googleapis.com/calendar/v3'

  def initialize(token)
    @token = token.expired? ? token.refresh_token! : token
  end

  def calendar_list
    fetch_items('/users/me/calendarList')
  end

  def calendar_events(calender_id = 'primary', queryParams = nil)
    fetch_items("/calendars/#{calender_id}/events?#{queryParams}")
  end

  def fetch_items(url)
    items = []
    response = self.class.get(url, headers)
    if response.code == 200
      items = response.parsed_response['items']
    end
    {
      items: items,
      nextPageToken: response.parsed_response['nextPageToken'],
      nextSyncToken: response.parsed_response['nextSyncToken']
    }
  end

  def headers
    {headers: {"Authorization" => "Bearer #{@token.access_token}"}}
  end
end
