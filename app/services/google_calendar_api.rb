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

  private

  def fetch_items(url)
    items = []
    response = self.class.get(url, headers)
    if response.code == 200
      items = response.parsed_response['items'].map do |item|
        case item['kind']
        when 'calendar#calendarListEntry'
          filter_calendar(item)
        when 'calendar#event'
          filter_event(item)
        end
      end
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

  def filter_calendar(calendar)
    {
      g_id: calendar['id'],
      summary: calendar['summary'],
      timezone: calendar['timeZone'],
      bg_color: calendar['backgroundColor'],
      fg_color: calendar['foregroundColor']
    }
  end

  def filter_event(event)
    {
      g_id: event['id'],
      summary: event['summary'],
      description: event['description'],
      location: event['location'],
      status: event['status'],
      html_link: event['htmlLink'],
      start_time: event['start']['dateTime'] || event['start']['date'],
      end_time: event['end']['dateTime'] || event['start']['date'],
      all_day_event: event['start']['date'] ? true : false
    }
  end
end
