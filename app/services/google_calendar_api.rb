class GoogleCalendarApi
  include HTTParty
  base_uri 'https://www.googleapis.com/calendar/v3'

  def initialize(token)
    @token = token
  end

  def list_calendar_lists
    self.class.get('/users/me/calendarList', headers)
  end

  def get_calendar_events(calender_id='primary')
    self.class.get("/calendars/#{calender_id}/events", headers)
  end

  def headers
    {headers: {"Authorization" => "Bearer #{@token.access_token}"}}
  end
end
