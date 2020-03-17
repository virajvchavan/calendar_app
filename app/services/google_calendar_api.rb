class GoogleCalendarApi
  include HTTParty
  base_uri 'https://www.googleapis.com/calendar/v3'

  def initialize(token)
    @token = token.expired? ? token.refresh_token! : token
  end

  def calendar_list(query_params = {})
    fetch_items(
      "/users/me/calendarList?#{query_params.try(:to_query)}"
    )
  end

  def calendar_events(calender_id = 'primary', query_params = {})
    fetch_items(
      "/calendars/#{calender_id}/events?#{query_params.try(:to_query)}"
    )
  end

  def watch_calendar_events(calendar_g_id)
    response = self.class.post(
      "/calendars/#{calendar_g_id}/events/watch",
      webhook_params('events', calendar_g_id)
    )

    if response.code == 200
      puts "Webook registered for calendar: #{calendar_g_id} /events (User #{@token.user_id})"
      puts "Success: #{response}"
    else
      puts "Error registering webook for calendar events (Calendar: #{calendar_g_id}, User #{@token.user_id})"
      puts "Error: #{response}"
    end
  end

  def watch_calendars
    response = self.class.post(
      '/users/me/calendarList/watch',
      webhook_params('calendars')
    )

    if response.code == 200
      puts "Webook registered for calendars list (User #{@token.user_id}). Sucess: #{response}"
    else
      puts "Error registering webook for calendars (User #{@token.user_id}). Error: #{response}"
    end
  end

  private

  def fetch_items(url)
    items = []
    response = self.class.get(url, auth_params)
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

  def auth_params
    { headers: { 'Authorization' => "Bearer #{@token.access_token}" } }
  end

  def webhook_params(webhook_type, calendar_g_id = nil)
    {
      headers: {
        'Authorization' => "Bearer #{@token.access_token}",
        'Content-Type': 'application/json'
      },
      body: {
        id: SecureRandom.uuid,
        type: 'webhook',
        address: "https://#{DOMAIN_NAME}/google_webhook_callback",
        token: "type=#{webhook_type}&userId=#{@token.user_id}&cId=#{calendar_g_id}"
      }.to_json
    }
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
      start_time: event['start'].try(:[], 'dateTime') || event['start'].try(:[], 'date'),
      end_time: event['end'].try(:[], 'dateTime') || event['start'].try(:[], 'date'),
      all_day_event: event['start'].try(:[], 'date') ? true : false
    }
  end
end
