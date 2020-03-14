class EventsController < ApplicationController
  before_action :authenticate
  def index
    service = GoogleCalendarApi.new(current_user.google_token)
    @events = service.get_calendar_events
  end
end
